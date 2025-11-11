//
//  HomeNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import Common
import Factory
import UIKit

protocol HomeNavigator: Navigator {
  func navigateToClaimDetail(from: UIViewController, claim: Claim)
}

struct DefaultHomeNavigator: HomeNavigator {
  private let launcher: Launching

  init(launcher: Launching) {
    self.launcher = launcher
  }
  
  var behavior: NavigationBehavior = .replaceRoot
  
  var viewController: UIViewController {
    @Injected(\.homeView) var view
    return UINavigationController(rootViewController: view.viewController)
  }
  
  func navigateToClaimDetail(from: UIViewController, claim: Claim) {
    @Injected(\.claimNavigator) var navigator
    navigator.navigateToClaimDetail(from: from, claim: claim)
  }
}
