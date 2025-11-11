//
//  ApiContract.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//


import Core
import Foundation
import UIKit

import Foundation

public enum ApiContract {
  case anonymous(api: NetworkModelRequest)
}

extension ApiContract {
  public var baseURL: URL {
    AppConfig.current.apiConfig.baseURL
  }

  var api: NetworkModelRequest {
    switch self {
    case .anonymous(let api): return api
    }
  }

  public var path: String {
    api.path
  }

  public var method: HTTPMethod {
    api.method
  }

  var task: Task {
    api.task
  }

  public var headers: [String: String]? {
    nil
  }
}
