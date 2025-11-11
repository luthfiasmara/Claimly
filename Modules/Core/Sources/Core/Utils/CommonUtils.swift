//
//  CommonUtils.swift
//  Core
//
//  Created by Luthfi Asmara on 11/11/25.
//

import UIKit

public func delay(bySeconds seconds: Double, closure: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    closure()
  }
}
