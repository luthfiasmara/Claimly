//
//  SplashContainer.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Factory
import SwiftUI
import Core

extension Container {
  var splashView: Factory<SplashView> {
    Factory(self) {
      @MainActor in SplashView(
        holder: self.holder(),
        navigator: self.splashNavigator()
      )
    }
  }
}

extension Container {
  var splashNavigator: Factory <SplashNavigator> {
    Factory(self) { @MainActor in DefaultSplashNavigator(launcher: self.launcher()) }
  }
}
