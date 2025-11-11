//
//  ModuleManager.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import Combine
import SwiftUI

public class ModuleManager {
  private var launchables: [Launchable] = []
  private weak var launcher: Launching?
  
  /// Additional properties for deeplink handling
  private var windowChecker: AnyCancellable?
  private let windowReadiness = CurrentValueSubject<UIWindow?, Never>(nil)
  private let currentTopViewControllerType = CurrentValueSubject<String?, Never>(nil)
  private let deeplinkURLToHandle = CurrentValueSubject<URL?, Never>(nil)
  private var cancellables = Set<AnyCancellable>()
  
  public init(launcher: Launching) {
    self.launcher = launcher
  }
  
  public func register(launchables: [Launchable]) {
    self.launchables.append(contentsOf: launchables)
    self.launchables.forEach({ $0.launcher = launcher })
  }
  
  public func launch(from window: UIWindow?, options: LaunchOptions) {
    guard let initialModule = launchables.compactMap({ $0 as? InitialLaunchable }).first else {
      return
    }
    initialModule.launch(in: window, options: options)
    
    if let window = window {
      observeDeeplinkReadiness(window: window)
    }
  }
  
  public func launchModule(identifier: ModuleIdentifier, in viewController: UIViewController, options: LaunchOptions) {
    guard let module = launchables.first(where: { $0.identifier == identifier }) else {
      print("Unknown Module: can not find the module with matching identifier")
      return
    }
    module.launch(in: viewController, options: options)
  }
  
  public func backToModule(identifier: ModuleIdentifier, from viewController: UIViewController, to destination: String) {
    guard let module = launchables.first(where: { $0.identifier == identifier }) else {
      print("Unknown Module: can not find the module with matching identifier")
      return
    }
    module.back(from: viewController, to: destination)
  }
  
  public func getLandingViewController(identifier: ModuleIdentifier, options: LaunchOptions) -> UIViewController? {
    guard let module = launchables.filter({ $0.identifier == identifier }).first else {
      print("Unknown Module: can not find the module with matching identifier")
      return nil
    }
    return module.landingViewController(with: options)
  }
  
  public func openDeeplink(url: URL) -> Bool {
    if let _ = deeplinkHandler(for: url) {
      deeplinkURLToHandle.send(url)
      return true
    }
    return false
  }
  
  public func observeDeeplinkReadiness(window: UIWindow) {
    windowChecker = Timer.publish(every: 2.0, on: .current, in: .common)
      .autoconnect()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        if window.isReadyToHandleDeeplink {
          self?.windowReadiness.send(window)
          self?.windowChecker?.cancel()
        }
      }
    
    Publishers.CombineLatest(windowReadiness,
                             deeplinkURLToHandle)
    .sink { [weak self] window, url in
      guard let viewController = window?.topViewController,
            let url = url else { return }
      viewController.dismiss(animated: false) {
        self?.launchDeeplink(from: viewController, url: url)
      }
    }
    .store(in: &cancellables)
  }
  
  private func deeplinkHandler(for url: URL) -> DeeplinkLauncher? {
    guard let scheme = url.scheme?.lowercased(),
          let host = url.host?.lowercased() else {
      return nil
    }
    
    let handlers = launchables.compactMap { $0 as? DeeplinkLauncher }
    var domainHandlers = handlers.filter {
      $0.supportedSchemes.map { $0.lowercased() }.contains(scheme.lowercased())
    }
    
    if scheme.lowercased() == "https" {
      domainHandlers = domainHandlers.filter {
        $0.supportedURLDomain(for: scheme)
          .map { $0.lowercased() }
          .contains(host.lowercased())
      }
    }
    
    return domainHandlers.first { $0.canOpen(url: url) }
  }

  
  private func launchDeeplink(from viewController: UIViewController, url: URL) {
    if let handler = deeplinkHandler(for: url) {
      handler.openDeeplink(from: viewController, url: url)
    }
  }
}
