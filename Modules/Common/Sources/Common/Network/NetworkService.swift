//
//  NetworkService.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Combine
import Core
import Foundation

public final class NetworkService {
  public static let shared = NetworkService()
  private init() {}
  
  public func fetch<T: Decodable>(
    api: ApiContract,
    output: T.Type
  ) -> AnyPublisher<T, GeneralError> {
    
    guard var url = URLComponents(string: api.baseURL.absoluteString + api.path) else {
      return Fail(error: GeneralError.invalidURL).eraseToAnyPublisher()
    }
    
    var request = URLRequest(url: url.url!)
    request.timeoutInterval = 60
    request.httpMethod = api.method.rawValue
    request.allHTTPHeaderFields = api.headers?.dictionary
    
    var urlParameters: [String: Any]?
    var bodyParameters: [String: Any]?
    switch api.task {
    case .requestPlain:
      break
    case .requestParameters(let parameters):
      bodyParameters = parameters
    case .requestCompositeParameters(let bodyParam, let urlParam):
      bodyParameters = bodyParam
      urlParameters = urlParam
    }
    
    do {
      switch api.method {
      case .get:
        if let parameters = urlParameters ?? bodyParameters {
          let queryItems = getQueryItem(from: parameters)
          url.queryItems = queryItems
          request.url = url.url
        }
      default:
        if let urlParameters = urlParameters {
          url.queryItems = getQueryItem(from: urlParameters)
          request.url = url.url
        }
        if let body = bodyParameters {
          request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        }
      }
    } catch {
      return Fail(error: GeneralError.encodingFailed).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryCatch { error -> AnyPublisher<(data: Data, response: URLResponse), GeneralError> in
        let urlError = error as URLError
        print("URLErrorTryCatch: \(urlError), as httpURLResponse: \(String(describing: urlError.userInfo[NSURLErrorFailingURLErrorKey] as? HTTPURLResponse))")
        
        return Fail(error: GeneralError.unknown).eraseToAnyPublisher()
      }
      .tryMap { result -> Data in
        guard let response = result.response as? HTTPURLResponse else {
          throw GeneralError.invalidResponse
        }
        
        guard response.statusCode < 500 else {
          throw GeneralError.middlewareError(code: response.statusCode, message: "Internal server error")
        }
        
        guard let jsonResponse = try? JSONSerialization.jsonObject(with: result.data, options: .allowFragments) as? [String: Any] else {
          print("[\(response.statusCode)] response api \(api.baseURL.absoluteString) = \(GeneralError.invalidResponse.localizedDescription)")
          if response.statusCode == 429 {
            throw GeneralError.rateLimit(timer: 0)
          } else {
            throw GeneralError.invalidResponse
          }
        }
        
        print("[\(response.statusCode)] response api \(api.baseURL.absoluteString) = \(jsonResponse)")
        
        guard 200..<300 ~= response.statusCode else {
          let errorMessage: String
          
          if let code = jsonResponse["errorCode"] as? String,
             let message = jsonResponse["message"] as? String {
            let url = URL(string: api.baseURL.absoluteString + api.path)
            if let url = url?.absoluteString, url.contains("compare") {
              errorMessage = "\(code)-\(message)"
            } else {
              errorMessage = message
            }
          } else if let errorsCheckout = jsonResponse["errors_checkout"] as? [[String: Any]],
                    let message = errorsCheckout.first?["message"] as? String {
            errorMessage = message
          } else {
            let errorKeys = ["error_message", "message", "error"]
            errorMessage = errorKeys.compactMap({ jsonResponse[$0] as? String }).first(where: { !$0.isEmpty }) ?? ""
          }
          
          if response.statusCode == 429 {
            let timer  = jsonResponse["timer"] as? Int ?? 0
            throw GeneralError.rateLimit(timer: timer)
          }
          
          throw GeneralError.middlewareError(code: response.statusCode, message: errorMessage)
        }
        
        // MARK: in case http status is 200 but expected to be error
        let errorKeys = ["error_message", "message", "error"]
        if let statusCode = jsonResponse["status"] as? Int,
           200..<300 ~= response.statusCode,
           statusCode != 404,
           let errorMessage = errorKeys.compactMap({ jsonResponse[$0] as? String }).first(where: { !$0.isEmpty }
           ) {
          throw GeneralError.middlewareError(code: response.statusCode, message: errorMessage)
        }
        
        return result.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        if let networkError = error as? GeneralError {
          return networkError
        } else if let decodingError = error as? DecodingError {
          return GeneralError.decodingError(decodingError)
        } else {
          return GeneralError.unknown
        }
      }
      .eraseToAnyPublisher()
  }
  
  func getQueryItem(from parameters: [String: Any]) -> [URLQueryItem]? {
    let queryItems = parameters.compactMap { key, value -> URLQueryItem? in
      if let value = value as? CustomStringConvertible {
        return URLQueryItem(name: key, value: value.description)
      }
      return nil
    }
    return queryItems
  }
  
  fileprivate func logRequest(_ api: ApiContract) {
    let url = "\(api.baseURL)\(api.path)"
    print("NetworkService : \(url)")
    print("NetworkService : \(String(describing: api.headers))")
    print("NetworkService : \(String(describing: api.method))")
    // too large string caused freeze
    let paramLog = String(describing: api.task)
    print("NetworkService : \(paramLog.count > 10000 ? "request too long to be printed out" : paramLog)")
  }
  
  func retryRequest(_ request: URLRequest, with newToken: String) -> URLRequest {
    var retryRequest = request
    retryRequest.setValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
    return retryRequest
  }
}
