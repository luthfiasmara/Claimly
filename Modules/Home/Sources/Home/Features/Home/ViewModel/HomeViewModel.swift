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
  private var cancellable: Set<AnyCancellable> = []

  @Injected(\.getClaims) private var getClaimsUseCase
  
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
