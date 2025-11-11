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
