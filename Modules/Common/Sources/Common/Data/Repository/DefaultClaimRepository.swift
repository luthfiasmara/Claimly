//
//  DefaultClaimRepository.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Foundation

public struct DefaultClaimRepository: ClaimRepository {
  fileprivate let remoteDataSource: CommonRemoteDataSource
  
  public init(remoteDataSource: CommonRemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }
  
  public func getClaims() -> AnyPublisher<[Claim], GeneralError> {
    return remoteDataSource.getClaims()
  }
}
