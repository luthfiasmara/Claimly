//
//  ClaimNavigator.swift
//  Home
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Core
import Common
import Factory
import UIKit

protocol ClaimNavigator: Navigator {
  func navigateToClaimDetail(from: UIViewController, claim: Claim)
}

struct DefaultClaimNavigator: ClaimNavigator {
  private let launcher: Launching

  init(launcher: Launching) {
    self.launcher = launcher
  }
  
  var behavior: NavigationBehavior = .push(animated: true)
  
  var viewController: UIViewController {
    return UIViewController()
  }
  
  func navigateToClaimDetail(from: UIViewController, claim: Claim) {
    @Injected(\.claimViewModel) var viewModel
    viewModel.claim = claim
    @Injected(\.claimDetailView) var nextView
    nextView.viewModel = viewModel
    navigate(to: nextView.viewController, from: from)
  }
}
