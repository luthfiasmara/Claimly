//
//  NetworkModel.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Foundation

public struct AnyEncodable: Encodable {
  private let _encode: (Encoder) throws -> Void
  
  public init<T: Encodable>(_ wrapped: T) {
    _encode = wrapped.encode
  }
  
  public func encode(to encoder: Encoder) throws {
    try _encode(encoder)
  }
}

public typealias HTTPHeaders = [String: String]

extension Dictionary where Key == String, Value == String {
  var dictionary: [String: String] { self }
}

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public protocol NetworkModelRequest {
  var path: String { get }
  var method: HTTPMethod { get }
  var task: Task { get }
  var additionalHeaders: HTTPHeaders? { get }
}

public extension NetworkModelRequest {
  var task: Task { .requestPlain }
}
