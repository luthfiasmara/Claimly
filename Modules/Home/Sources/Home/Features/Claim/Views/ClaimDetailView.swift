//
//  ClaimDetailView.swift
//  Home
//
//  Created by Luthfi Asmara on 11/11/25.
//

import SwiftUI
import CommonUI
import Common
import Combine
import Factory

struct ClaimDetailView: WrappedView {
  var holder: WrapperHolder
  @Injected(\.claimNavigator) var navigator
  @State var claim: Claim = Claim()
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          if let title = claim.title {
            Text(title)
          }
          Spacer()
        }
        .padding()
      }
      
      Spacer()
    }
  }
}
