//
//  AppConfig.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import Foundation

public enum AppEnvironment {
  case development
  case staging
  case production
}

public struct AppConfig {
  private static var _current = AppConfig(environment: .development)
  public static var current: AppConfig {
    _current
  }
  
  public static func setCurrent(_ config: AppConfig) {
    _current = config
  }
  
  public var environment: AppEnvironment
  
  public init(environment: AppEnvironment) {
    self.environment = environment
  }
  
  public var apiConfig: APIConfiguration {
    switch environment {
    case .development:
      return APIConfiguration.developmentConfig()
    case .staging:
      return APIConfiguration.stagingConfig()
    case .production:
      return APIConfiguration.productionConfig()
    }
  }
}

