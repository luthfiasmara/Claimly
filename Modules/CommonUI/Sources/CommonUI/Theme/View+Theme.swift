//
//  View+Theme.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//

import SwiftUI

public extension UIViewController {
  var theme: Theme {
    Themes.current.value
  }
}

public extension View {
  var theme: Theme {
    Themes.current.value
  }
  
  func typography(_ token: TypographyToken) -> some View {
    self.font(token.font)
  }
  
  func styled(with typographyToken: TypographyToken, color: Color? = nil) -> some View {
    self
      .font(typographyToken.font)
      .foregroundColor(color ?? theme.colors.primaryText)
  }
  
  func onThemeChange(perform action: @escaping (Theme) -> Void) -> some View {
    self.onReceive(Themes.current) { theme in
      action(theme)
    }
  }
}
