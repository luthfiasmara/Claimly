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
  @ObservedObject var viewModel: ClaimViewModel
  
  init(holder: WrapperHolder, viewModel: ClaimViewModel) {
    self.holder = holder
    self._viewModel = .init(wrappedValue: viewModel)
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
        if let id = viewModel.claim.id {
          VStack(alignment: .leading, spacing: 8) {
            Text("Claim ID: ")
              .typography(theme.typography.textL.regular)
              .foregroundColor(theme.colors.secondaryText)
            
            Text(id.toString())
              .typography(theme.typography.textL.regular)
              .foregroundColor(theme.colors.primaryText)
          }
        }
        
        if let userId = viewModel.claim.userId {
          VStack(alignment: .leading, spacing: 8) {
            Text("Claimant ID : ")
              .typography(theme.typography.textL.regular)
              .foregroundColor(theme.colors.secondaryText)
            
            Text(userId.toString())
              .typography(theme.typography.textL.regular)
              .foregroundColor(theme.colors.primaryText)
          }
        }
      
      
      if let title = viewModel.claim.title {
          Text(title)
            .typography(theme.typography.text2XL.bold)
            .foregroundColor(theme.colors.primaryText)
      }
      
      if let body = viewModel.claim.body {
        Text(body)
          .typography(theme.typography.textL.regular)
          .foregroundColor(theme.colors.secondaryText)
      }
      
      Spacer()
    }
  }
}
