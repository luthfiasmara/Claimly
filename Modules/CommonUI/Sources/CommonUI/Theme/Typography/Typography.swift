//
//  Typography.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//


import SwiftUI

public struct TypographyToken {
  public let fontType: UIFont.FontType
  public let fontWeight: Font.Weight
  public let fontSize: CGFloat
  public let lineHeight: CGFloat
  public let letterSpacing: CGFloat
  
  public init(
    fontType: UIFont.FontType,
    fontWeight: Font.Weight = .regular,
    fontSize: CGFloat,
    lineHeight: CGFloat,
    letterSpacing: CGFloat = 0
  ) {
    self.fontType = fontType
    self.fontWeight = fontWeight
    self.fontSize = fontSize
    self.lineHeight = lineHeight
    self.letterSpacing = letterSpacing
  }
  
  var font: Font {
    return Font.custom(fontType.rawValue, size: fontSize)
      .weight(fontWeight)
  }
  
  public var uiFont: UIFont {
    return UIFont(name: fontType.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
  }
}

public protocol BaseTextTypography {
  var bold: TypographyToken { get set }
  var semiBold: TypographyToken { get set }
  var regular: TypographyToken { get set }
}

public struct Typography {
  public struct Heading {
    /// Size 24
    public var headingL: TypographyToken
    /// Size 20
    public var headingM: TypographyToken
    /// Size 18
    public var headingS: TypographyToken
    /// Size 16
    public var headingXs: TypographyToken
  }
  
  public struct Text3XL: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400
    public var regular: TypographyToken
  }
  
  public struct Text2XL: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400
    public var regular: TypographyToken
  }
  
  public struct TextXL: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400
    public var regular: TypographyToken
  }
  
  public struct TextL: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400
    public var regular: TypographyToken
  }
  
  public struct TextM: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400, Line Height 160%
    public var regular: TypographyToken
    /// Weight 400, Line Height 130%
    public var regularS: TypographyToken
  }
  
  public struct TextS: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400
    public var regular: TypographyToken
  }

  public struct TextXS: BaseTextTypography {
    /// Weight 700
    public var bold: TypographyToken
    /// Weight 600
    public var semiBold: TypographyToken
    /// Weight 400, Line Height 160%
    public var regular: TypographyToken
    /// Weight 400, Line Height 130%
    public var regularS: TypographyToken

  }
  
  public struct Strikethrough {
    /// Weight 400, Line Height 160%
    public var strikethrough: TypographyToken
  }
  
  /// Style Bold
  public var heading: Self.Heading
  /// Size 20
  public var text3XL: Self.Text3XL
  /// Size 18
  public var text2XL: Self.Text2XL
  /// Size 16
  public var textXL: Self.TextXL
  /// Size 14
  public var textL: Self.TextL
  /// Size 12
  public var textM: Self.TextM
  /// Size 10
  public var textS: Self.TextS
  /// Size 8
  public var textXS: Self.TextXS
  /// Size 12
  public var strikethrough: Self.Strikethrough
}

extension TypographyToken {
  var attributes: [NSAttributedString.Key : Any] {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeight
    paragraphStyle.alignment = .left
    return [
      .font: uiFont,
      .paragraphStyle: paragraphStyle
    ]
  }
  
  func attributtedString(with string: String, withoutParagraphStyle: Bool = false) -> NSMutableAttributedString {
    NSMutableAttributedString(
      string: string,
      attributes: attributes.filter({ item in
        withoutParagraphStyle ? item.key != .paragraphStyle : true
      })
    )
  }
}
