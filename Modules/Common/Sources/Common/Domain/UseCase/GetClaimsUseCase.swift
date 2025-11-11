//
//  GetClaimsUseCase.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Foundation

public protocol GetClaimsUseCase {
  func execute() -> AnyPublisher<[Claim], GeneralError>
}

open class GetClaims: GetClaimsUseCase {
  private let repository: ClaimRepository

  public init(repository: ClaimRepository) {
    self.repository = repository
  }

  public func execute() -> AnyPublisher<[Claim], GeneralError> {
    repository.getClaims()
  }
}
