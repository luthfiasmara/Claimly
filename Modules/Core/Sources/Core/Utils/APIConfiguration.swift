//
//  APIConfiguration.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import Foundation

public struct APIConfiguration {
  public var baseURL: URL
}

// swiftlint:disable:next force_unwrapping
extension APIConfiguration {
  static func developmentConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://jsonplaceholder.typicode.com/")
    
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    
    return APIConfiguration(baseURL: baseURL)
  }
  
  static func stagingConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://api-staging.com/")
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    
    return APIConfiguration(baseURL: baseURL)
  }
  
  static func productionConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://api-prod.com/")
    
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    
    return APIConfiguration(baseURL: baseURL)
  }
}
