//
//  ClaimsResult.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Foundation

public class BaseClaimResponse<T>: Codable where T : Codable {
  public var version: String?
  public var build: String?
  public var appName: String?
  public var id: String?
  public var data: T?
  public var message: String?
}
