//
//  HomeModule.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Common
import Core
import SwiftUI
import Factory

public class HomeModule: InitialLaunchable {
  public var identifier: ModuleIdentifier = .home
  
  public var launcher: Launching? {
    didSet {
      if let launcher {
        Container.shared.launcher.register { launcher }
      }
    }
  }
  
  public init() {}
  
  var splashNavigator: SplashNavigator {
    Container.shared.splashNavigator()
  }
  
  var homeNavigator: HomeNavigator {
    Container.shared.homeNavigator()
  }

  public func landingViewController(with option: LaunchOptions) -> UIViewController {
    @Injected(\.homeView) var view
    return view.viewController
  }
  
  public func launch(in viewController: UIViewController, options: LaunchOptions) {
    switch options {
    case .empty:
      homeNavigator.navigate(from: viewController)
    case .targeted(let identifier, _):
      switch identifier {
      default: break
      }

    }
  }
  
  public func launch(in window: UIWindow?, options: LaunchOptions) {
    splashNavigator.navigate(from: window)
  }
  
  public func back(from viewController: UIViewController, to destination: String) {
    switch destination {
    case "home":
      homeNavigator.navigate(from: viewController)
    default:
      break
    }
  }
}
