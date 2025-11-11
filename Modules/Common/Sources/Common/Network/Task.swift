//
//  Task.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//


import Foundation

/// Represents an HTTP task.
public enum Task {
  /// A request with no additional data.
  case requestPlain
  
  /// A requests body set with encoded parameters.
  case requestParameters(parameters: [String: Any])
  
  /// A requests body set with encoded parameters combined with url parameters.
  case requestCompositeParameters(bodyParameters: [String: Any], urlParameters: [String: Any])
}