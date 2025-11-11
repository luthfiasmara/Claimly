//
//  HomeContainer.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import Common
import Factory

// MARK: - View
extension Container {
  var homeView: Factory<HomeView> {
    Factory(self) { @MainActor in HomeView(holder: self.holder()) }
  }
  
  var claimDetailView: Factory<ClaimDetailView> {
    Factory(self) { @MainActor in ClaimDetailView(holder: self.holder(), viewModel: self.claimViewModel()) }
  }
}

// MARK: - View Model
extension Container {
  var homeViewModel: Factory<HomeViewModel> {
    Factory(self) { @MainActor in HomeViewModel() }
  }
  
  var claimViewModel: Factory<ClaimViewModel> {
    Factory(self) { @MainActor in ClaimViewModel() }
  }
}

// MARK: - Navigator
extension Container {
  var homeNavigator: Factory<HomeNavigator> {
    Factory(self) { @MainActor in DefaultHomeNavigator(launcher: self.launcher()) }
  }
  
  var claimNavigator: Factory<ClaimNavigator> {
    Factory(self) { @MainActor in DefaultClaimNavigator(launcher: self.launcher()) }
  }
}

