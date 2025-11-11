//
//  HomeViewModel.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Core
import Common
import Combine
import Foundation
import Factory

final class HomeViewModel: ObservableObject {
  @Published var claims: DataState<[Claim]> = .initiate
  @Published var claimList: [Claim] = []
  @Published var searchText: String = ""
  @Published private(set) var filteredClaims: [Claim] = []

  
  private var cancellable: Set<AnyCancellable> = []

  @Injected(\.getClaims) private var getClaimsUseCase
  
  init() {
    Publishers.CombineLatest($claimList, $searchText)
      .map { claims, searchText in
        guard !searchText.isEmpty else { return claims }
        return claims.filter {
          ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
      }
      .receive(on: DispatchQueue.main)
      .assign(to: \.filteredClaims, on: self)
      .store(in: &cancellable)
  }

  
  func getClaims() {
    claims = .loading
    
    getClaimsUseCase.execute()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        guard let self = self else { return }
        switch completion {
          case .failure(let error):
            claims = .failed(reason: error)
          case .finished:
            break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        self.claims = .success(data: data)
      }
      .store(in: &cancellable)
  }
}
