//
//  Claim.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Foundation

public struct Claim: Codable {
  public let userId: Int?
  public let id: Int?
  public let title: String?
  public let body: String?
  
  public init(userId: Int? = nil, id: Int? = nil, title: String? = nil, body: String? = nil) {
    self.userId = userId
    self.id = id
    self.title = title
    self.body = body
  }
}
