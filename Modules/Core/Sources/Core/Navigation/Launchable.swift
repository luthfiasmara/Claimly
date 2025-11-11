//
//  Launchable.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import SwiftUI

public protocol Launchable: AnyObject {
  var identifier: ModuleIdentifier { get }
  var launcher: Launching? { get set }
  
  func landingViewController(with option: LaunchOptions) -> UIViewController
  func launch(in viewController: UIViewController, options: LaunchOptions)
  func back(from viewController: UIViewController, to destination: String)
}

public enum LaunchOptions {
  case empty
  case targeted(destination: String, params: [String: Any]?)
}

public protocol InitialLaunchable: Launchable {
  func launch(in window: UIWindow?, options: LaunchOptions)
}

public protocol Launching: AnyObject {
  var hostApp: UIApplication? { get }
  
  func launchModule(identifier: ModuleIdentifier, in viewController: UIViewController, options: LaunchOptions)
  func landingViewController(identifier: ModuleIdentifier, with option: LaunchOptions) -> UIViewController?
  func openDeeplink(url: URL) -> Bool
  func backToModule(identifier: ModuleIdentifier, from viewController: UIViewController, to destination: String)
}

public extension Launchable {
  func back(from viewController: UIViewController, to destination: String) { }
}

public extension Launching {
  func backToModule(identifier: ModuleIdentifier, from viewController: UIViewController, to destination: String) { }
}
