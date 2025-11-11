//
//  AppDelegate.swift
//  elporto
//
//  Created by Luthfi Asmara on 31/07/25.
//

import UIKit
import SwiftUI
import Combine
import Common
import CommonUI
import Core
import Home

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, Launching {
  var hostApp: UIApplication?
  var window: UIWindow?
  var moduleManager: ModuleManager?
  
  var notificationUserInfo: [AnyHashable: Any]?
  
  private var cancellables = Set<AnyCancellable>()
  
  static var orientationLock = UIInterfaceOrientationMask.portrait {
    didSet {
      if #available(iOS 16.0, *) {
        UIApplication.shared.connectedScenes.forEach { scene in
          if let windowScene = scene as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
          }
        }
        UIViewController.attemptRotationToDeviceOrientation()
      } else {
        if orientationLock == .landscape {
          UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        } else {
          UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
      }
    }
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    hostApp = application
    
    initiateModules()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    moduleManager?.launch(from: window, options: .empty)
    window?.makeKeyAndVisible()
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, _ in
      if authorized {
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      }
    }
    
    return true
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void) -> Bool {
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
          let url = userActivity.webpageURL,
          let _ = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
          )
    else {
      return false
    }
    
    if openDeeplink(url: url) {
      return true
    }
    
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return openDeeplink(url: url)
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return AppDelegate.orientationLock
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
  }
  
  func launchModule(identifier: ModuleIdentifier, in viewController: UIViewController, options: LaunchOptions) {
    moduleManager?.launchModule(identifier: identifier, in: viewController, options: options)
  }
  
  func landingViewController(identifier: ModuleIdentifier, with option: LaunchOptions) -> UIViewController? {
    moduleManager?.getLandingViewController(identifier: identifier, options: option)
  }
  
  func backToModule(identifier: ModuleIdentifier, from viewController: UIViewController, to destination: String) {
    moduleManager?.backToModule(identifier: identifier, from: viewController, to: destination)
  }
  
  func openDeeplink(url: URL) -> Bool {
    moduleManager?.openDeeplink(url: url) ?? false
  }
  
  func initiateModules() {
    moduleManager = ModuleManager(launcher: self)
    moduleManager?.register(launchables: [
      HomeModule()
    ])
  }
}
