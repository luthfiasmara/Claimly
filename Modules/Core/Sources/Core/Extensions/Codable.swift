//
//  Codable.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Foundation

public extension Encodable {
  func toJSONString() -> String? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.withoutEscapingSlashes, .sortedKeys]
    guard let encodedData = try? encoder.encode(self),
          let encodedString = String(data: encodedData, encoding: .utf8)
    else { return nil }
    return encodedString
  }
  
  func toDictionary(cleanEmpty: Bool = true, isPretty: Bool = false) -> [String: Any] {
    let encoder = JSONEncoder()
    if isPretty {
      encoder.outputFormatting = .prettyPrinted
    }
    
    guard let data = try? encoder.encode(self),
          let jsonObject = try? JSONSerialization.jsonObject(with: data),
          let dict = jsonObject as? [String: Any] else {
      return [:]
    }

    guard cleanEmpty else { return dict }

    var result: [String: Any] = [:]

    for (key, value) in dict {
      // Special handling for filters and facets
      if key == "filters" || key == "facets",
         let nested = value as? [String: Any] {
        for (nestedKey, nestedValue) in nested {
          result["\(key)[\(nestedKey)]"] = nestedValue
        }
      } else {
        result[key] = value
      }
    }

    return result.filter { key, value in
      if let str = value as? String {
        return !str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      } else if let arr = value as? [Any] {
        return !arr.isEmpty
      } else if let dictVal = value as? [String: Any] {
        return !dictVal.isEmpty
      } else if value is NSNull {
        return false
      }
      return true
    }
  }
  
  var parameters: [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      return [:]
    }

    var result: [String: Any] = [:]

    for (key, value) in dict {
      // Special handling for filters and facets
      if key == "filters" || key == "facets",
         let nested = value as? [String: Any] {
        for (nestedKey, nestedValue) in nested {
          result["\(key)[\(nestedKey)]"] = nestedValue
        }
      } else {
        result[key] = value
      }
    }

    return result
  }
}
