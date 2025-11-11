//
//  HomeContainer.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import Factory

extension Container {
  var homeView: Factory<HomeView> {
    Factory(self) { @MainActor in HomeView(holder: self.holder()) }
  }
}

extension Container {
  var homeNavigator: Factory <HomeNavigator> {
    Factory(self) { @MainActor in DefaultHomeNavigator(launcher: self.launcher()) }
  }
}
