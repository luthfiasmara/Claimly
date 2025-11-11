//
//  DefaultUIFont.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//

import UIKit

extension UIFont {
  public enum FontType: String {
    case outfitBold = "Outfit-Bold"
    case outfitSemibold = "Outfit-SemiBold"
    case outfitRegular = "Outfit-Regular"
  }
  
  internal static func custom(type: FontType, size: CGFloat) -> UIFont {
    return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
  }
  
  static func loadCustomFont() {
    self.jbsRegisterFont(withFilename: FontType.outfitBold)
    self.jbsRegisterFont(withFilename: FontType.outfitSemibold)
    self.jbsRegisterFont(withFilename: FontType.outfitRegular)
  }
  
  static func jbsRegisterFont(withFilename filename: FontType) {
    
    guard let pathForResourceString = Bundle.main.path(forResource: filename.rawValue, ofType: "ttf") else {
      print("UIFont+:  Failed to register font - path for resource not found.")
      return
    }
    
    guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
      print("UIFont+:  Failed to register font - font data could not be loaded.")
      return
    }
    
    guard let dataProvider = CGDataProvider(data: fontData) else {
      print("UIFont+:  Failed to register font - data provider could not be loaded.")
      return
    }
    
    guard let font = CGFont(dataProvider) else {
      print("UIFont+:  Failed to register font - font could not be loaded.")
      return
    }
    
    var errorRef: Unmanaged<CFError>? = nil
    if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
      print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
    }
  }
}
