//
//  CommonRemoteDataSource.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Foundation

public protocol CommonRemoteDataSource {
  func getClaims() -> AnyPublisher<[Claim], GeneralError>
}

public struct DefaultCommonRemoteDataSource: CommonRemoteDataSource {
  public init() {}
  
  public func getClaims() -> AnyPublisher<[Claim], GeneralError> {
    let api = ApiContract.anonymous(api: ClaimApi.getClaimList)
    return NetworkService.shared
      .fetch(api: api, output: [Claim].self)
      .mapError { $0.mapToGeneralError() }
      .eraseToAnyPublisher()
  }
}
