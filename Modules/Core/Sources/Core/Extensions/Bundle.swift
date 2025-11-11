//
//  Bundle.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Foundation
import UIKit

public extension Bundle {
  public var releaseVersionNumber: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  public var buildVersionNumber: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }
  
  public var iosVersion: String? {
    return UIDevice.current.systemVersion
  }
  
  public var applicationName: String? {
    return infoDictionary?["CFBundleName"] as? String
  }
}
