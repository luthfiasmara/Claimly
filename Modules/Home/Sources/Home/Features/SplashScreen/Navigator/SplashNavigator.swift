//
//  SplashNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import Factory
import UIKit

protocol SplashNavigator: InitialNavigator {
  func navigateToHome(from viewController: UIViewController)
}

struct DefaultSplashNavigator: SplashNavigator {
  var viewController: UIViewController {
    @Injected(\.splashView) var view
    return view.viewController
  }
  
  private let launcher: Launching?

  init(launcher: Launching?) {
    self.launcher = launcher
  }
  
  func navigateToHome(from viewController: UIViewController) {
    @Injected(\.homeNavigator) var navigator
    navigator.navigate(from: viewController)
  }
}
