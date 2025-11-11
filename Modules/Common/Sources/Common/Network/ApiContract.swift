//
//  ApiContract.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//


import Core
import Foundation
import UIKit

public enum ApiContract {
  case anonymous(api: NetworkModelRequest)
}

extension ApiContract {
  public var baseURL: URL {
      return AppConfig.current.apiConfig.baseURL
  }
  
  var api: NetworkModelRequest {
      return api
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
    switch self {
    case .anonymous:
      return getHeaders(type: .anonymous)
    }
  }
}

private enum HeaderType {
  case anonymous
  case authorized
}

extension ApiContract {
  fileprivate func getHeaders(type: HeaderType) -> HTTPHeaders {
    var header = ["Accept": "application/json"]

    // MARK: used for every API request
    header["Content-Type"] = "application/json"
    header["Device"] = UIDevice.current.name
    header["Device-Platform"] = "ios"
    header["Platform"] = "elporto-ios"
    header["Source"] = "elporto"
    header["x-source"] = "elporto"
     
    api.additionalHeaders?.forEach({ keyValue in
      header[keyValue.key] = keyValue.value
    })
    
    return header
  }
}
