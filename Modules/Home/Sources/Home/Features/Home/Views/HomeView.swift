//
//  HomeView.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import SwiftUI
import CommonUI
import Combine
import Factory

struct HomeView: WrappedView {
  var holder: WrapperHolder
  @Injected(\.homeNavigator) var navigator
  @InjectedObject(\.homeViewModel) var viewModel
  
  var body: some View {
    VStack {
      TextField("Search claims...", text: $viewModel.searchText)
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 12)
        .padding(.top, 8)
      
      ScrollView {
        ForEach(viewModel.filteredClaims, id: \.id) { claim in
          VStack(alignment: .leading, spacing: 8) {
            if let title = claim.title {
                Text(title)
                  .typography(theme.typography.text2XL.bold)
                  .foregroundColor(theme.colors.primaryText)
            }
            
            if let body = claim.body {
              Text(body)
                .typography(theme.typography.textL.regular)
                .foregroundColor(theme.colors.secondaryText)
                .lineLimit(2)
            }
          }
          .padding(12)
          .frame(width: UIScreen.main.bounds.width - 24, alignment: .leading)
          .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3), lineWidth: 1))
          .padding(.horizontal, 12)
          .onTapGesture {
            guard let viewController = holder.viewController else { return }
            navigator.navigateToClaimDetail(from: viewController, claim: claim)
          }
        }
      }
      .padding(.horizontal, 12)
    }
    .onAppear {
      viewModel.getClaims()
    }
    .dataState(
      viewModel.$claims,
      onSuccess: { data in
        viewModel.claimList = data
      },
      onLoading: { isLoading in
        if isLoading {
          showLoading()
        } else {
          dismissLoading()
        }
      },
      onFailed: { _ in
      }
    )
  }
}
