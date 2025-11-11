//
//  Date.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Foundation

public extension Date {
  func toString(to format: String = "d MMM yyyy", locale: Locale = Locale(identifier: "id_ID")) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = locale
    let stringDate: String = dateFormatter.string(from: self)
    return stringDate
  }
}
