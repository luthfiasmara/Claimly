//
//  ClaimApi.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Core
import Foundation

import Core
import Foundation

enum ClaimApi {
  case getClaimList
}

extension ClaimApi: NetworkModelRequest {
  var path: String {
    switch self {
    case .getClaimList:
      return "posts"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getClaimList:
      return .get 
    }
  }
  
  var task: Task {
    switch self {
    case .getClaimList:
      return .requestPlain
    }
  }
  
  var additionalHeaders: HTTPHeaders? {
    nil
  }
}
