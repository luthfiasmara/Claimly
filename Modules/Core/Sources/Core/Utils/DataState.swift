//
//  DataState.swift
//  Core
//
//  Created by Luthfi Asmara on 11/11/25.
//


import Combine
import Foundation

public enum DataState<T>: Equatable {
  case initiate
  case loading
  case empty
  case failed(reason: Error)
  case inProgress(progress: Double)
  case success(data: T)
  
  public var value: T? {
    if case .success(let data) = self {
      return data
    }
    return nil
  }
  
  public var isLoading: Bool {
    if case .loading = self {
      return true
    }
    return false
  }
  
  public var error: Error? {
    if case .failed(let error) = self {
      return error
    }
    return nil
  }
  
  public static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
    lhs.localIdentifier == rhs.localIdentifier
  }
  
  private var localIdentifier: Int {
    switch self {
    case .initiate: 0
    case .loading: 1
    case .failed: 2
    case .inProgress: 3
    case .success: 4
    case .empty: 5
    }
  }
}

public extension Published.Publisher where Value: DataStateProtocol {
  var isLoading: AnyPublisher<Bool, Never> {
    self
      .map { $0.isLoading }
      .eraseToAnyPublisher()
  }
}

public protocol DataStateProtocol {
  var isLoading: Bool { get }
}

extension DataState: DataStateProtocol {}