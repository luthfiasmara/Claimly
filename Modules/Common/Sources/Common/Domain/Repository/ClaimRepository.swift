//
//  ClaimRepository.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Foundation

public protocol ClaimRepository {
  func getClaims() -> AnyPublisher<[Claim], GeneralError>
}
