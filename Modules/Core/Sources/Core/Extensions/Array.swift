//
//  Array.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Foundation

public extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

public extension MutableCollection {
  subscript(safe index: Index) -> Element? {
    get {
      return indices.contains(index) ? self[index] : nil
    }
    
    set(newValue) {
      if let newValue = newValue, indices.contains(index) {
        self[index] = newValue
      }
    }
  }
}

public extension Array where Element == Int {
  var calculateTotal: Int {
    self.reduce(0, +)
  }
}

public extension Array {
  func randomElements() -> [Element] {
    let count = Int.random(in: 1...self.count)
    return Array(self.shuffled().prefix(count))
  }

  var isNotEmpty: Bool {
    !self.isEmpty
  }
}

public extension Array where Element: Hashable {
  func removingDuplicates() -> [Element] {
    var uniqueSet = Set<Element>()
    var orderedArray: [Element] = []

    for element in self where !uniqueSet.contains(element) {
      uniqueSet.insert(element)
      orderedArray.append(element)
    }

    return orderedArray
  }
  
  func removingDuplicates<T: Hashable>(byKey key: (Element) -> T) -> [Element] {
    var result: [Element] = []
    var seen = Set<T>()
    for value in self where seen.insert(key(value)).inserted {
      result.append(value)
    }
    return result
  }
}
