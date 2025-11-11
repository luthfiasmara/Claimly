//
//  ModuleContainer.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import CommonUI
import Factory
import Foundation

// MARK: - Launcher & Holder
extension Container {
  var launcher: Factory<Launching> {
    Factory(self) {
      fatalError("Launcher must be registered at startup")
    }.scope(.singleton)
  }
  
  var holder: Factory<WrapperHolder> {
    Factory(self) {
      WrapperHolder()
    }.scope(.unique)
  }
}
