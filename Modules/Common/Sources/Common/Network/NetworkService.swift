//
//  NetworkService.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Foundation

public final class NetworkService {
  public static let shared = NetworkService()
  private init() {}
  
  public func fetch<T: Decodable>(
    api: ApiContract,
    output: T.Type
  ) -> AnyPublisher<T, GeneralError> {
    
    guard var url = URLComponents(string: api.baseURL.absoluteString + api.path) else {
      return Fail(error: .invalidURL).eraseToAnyPublisher()
    }
    
    var request = URLRequest(url: url.url!)
    request.httpMethod = api.method.rawValue
    request.timeoutInterval = 60
    request.allHTTPHeaderFields = api.headers?.dictionary
    
    switch api.task {
    case .requestPlain:
      break
    case .requestParameters(let parameters):
      if api.method == .get {
        url.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        request.url = url.url
      } else {
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
      }
    case .requestCompositeParameters(let bodyParam, let urlParam):
      url.queryItems = urlParam.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
      request.url = url.url
      request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParam)
    }
    
    // MARK: - Fetch data
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { result -> Data in
        guard let response = result.response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
          throw GeneralError.invalidResponse
        }
        return result.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        if let generalError = error as? GeneralError {
          return generalError
        } else if let decodingError = error as? DecodingError {
          return GeneralError.decodingError(decodingError)
        } else {
          return GeneralError.unknown
        }
      }
      .eraseToAnyPublisher()
  }
}
