//
//  GeneralError.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//


import Foundation

public enum GeneralError: Swift.Error {
  case noInternetConnection
  case invalidURL
  case requestFailed(Error)
  case statusCode(Int)
  case decodingError(Error)
  case encodingFailed
  case emptyData
  case invalidResponse
  case unknown
  case coreDataError(Error)
  case middlewareError(code: Int, message: String?)
  case rateLimit(timer: Int)
}

extension Error {
  public func mapToGeneralError() -> GeneralError {
    if let generalError = self as? GeneralError {
      return generalError
    } else {
      return .requestFailed(self)
    }
  }
}
