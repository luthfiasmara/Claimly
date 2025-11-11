//
//  View.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Common
import Core
import SwiftUI

extension View {
  public func showLoading() {
    let loading = CommonLoadingView()
    loading.show()
  }

  public func dismissLoading(willDismissQueue: Bool = false) {
    let loading = CommonLoadingView()
    delay(bySeconds: 0.5) {
      loading.dismiss(willDismissQueue: willDismissQueue)
    }
  }
}

extension View {
  
  public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
      clipShape( RoundedCorner(radius: radius, corners: corners) )
  }
}

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

