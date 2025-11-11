//
//  DeeplinkLauncher.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import UIKit

public protocol DeeplinkLauncher: Launchable {
  var supportedSchemes: [String] { get }
  
  func supportedURLDomain(for scheme: String) -> [String]
  func canOpen(url: URL) -> Bool
  
  @discardableResult
  func openDeeplink(from viewController: UIViewController, url: URL) -> Bool
}

public extension DeeplinkLauncher {
  var supportedSchemes: [String] {
    switch AppConfig.current.environment {
    case .development:
      return ["elportoDev", "https"]
    case .staging:
      return ["elportoStaging", "https"]
    case .production:
      return ["elporto", "https"]
    }
  }
  
  func supportedURLDomain(for scheme: String) -> [String] {
    return [
      "elporto.com"
    ]
  }
}

public extension UIWindow {
  var isReadyToHandleDeeplink: Bool {
    rootViewController is UITabBarController
  }
  
  var topViewController: UIViewController? {
    let tabViewController = rootViewController as? UITabBarController
    let navigationController = tabViewController?.selectedViewController as? UINavigationController
    return navigationController?.visibleViewController
  }
}
