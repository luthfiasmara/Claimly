//
//  DarkTheme.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//


import SwiftUI

struct DarkTheme: Theme {
  var colors: Colors {
    Colors(
      primary: ColorVariant(
        main: Color(hex: ColorPrimitives.colorPrimaryMain),
        v20: Color(hex: ColorPrimitives.colorPrimary20)
      ),
      secondary: ColorVariant(
        main: Color(hex: ColorPrimitives.colorPrimaryMain),
        v20: Color(hex: ColorPrimitives.colorPrimary20)
      ),
      dark: Color(hex: ColorPrimitives.colorNeutralDark),
      light: Color(hex: ColorPrimitives.colorNeutralLight),
      subtleText: Color(hex: ColorPrimitives.colorNeutralGray),
      icon: Color(hex: ColorPrimitives.colorNeutralGray),
      stroke: Color(hex: ColorPrimitives.colorNeutralGray),
      line: Color(hex: ColorPrimitives.colorSupportLine),
      danger: Color(hex: ColorPrimitives.colorSupportDanger),
      warning: Color(hex: ColorPrimitives.colorAccentYellow),
      rating: Color(hex: ColorPrimitives.colorNeutralGray),
      success: Color(hex: ColorPrimitives.colorNeutralGray),
      primaryText: Color(hex: ColorPrimitives.colorNeutralDark),
      secondaryText: Color(hex: ColorPrimitives.colorNeutralGray),
      blackText: Color(hex: ColorPrimitives.colorNeutralBlack),
      orangeAccent: Color(hex: ColorPrimitives.colorOrangeDark)
    )
  }
  
  var typography: Typography {
    Typography(
      heading: Typography.Heading(
        headingL: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 24,
          lineHeight: 0.3,
          letterSpacing: -0.32
        ),
        headingM: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 20,
          lineHeight: 1.3,
          letterSpacing: 0.32
        ),
        headingS: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 18,
          lineHeight: 1.3,
          letterSpacing: 0.3
        ),
        headingXs: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 16,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      text3XL: Typography.Text3XL(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 20,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 20,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 20,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      text2XL: Typography.Text2XL(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 18,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 18,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 18,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      textXL: Typography.TextXL(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 16,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 16,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 16,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      textL: Typography.TextL(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 14,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 14,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 14,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      textM: Typography.TextM(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 12,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 12,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 12,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regularS: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 12,
          lineHeight: 1.3,
          letterSpacing: 0.3
        )
      ),
      textS: Typography.TextS(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 10,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 10,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 10,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      ),
      textXS: Typography.TextXS(
        bold: TypographyToken(
          fontType: .outfitBold,
          fontWeight: .bold,
          fontSize: 8,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        semiBold: TypographyToken(
          fontType: .outfitSemibold,
          fontWeight: .semibold,
          fontSize: 8,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regular: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 8,
          lineHeight: 1.6,
          letterSpacing: 0.3
        ),
        regularS: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 8,
          lineHeight: 1.3,
          letterSpacing: 0.3
        )
      ),
      strikethrough: Typography.Strikethrough(
        strikethrough: TypographyToken(
          fontType: .outfitRegular,
          fontWeight: .regular,
          fontSize: 8,
          lineHeight: 1.6,
          letterSpacing: 0.3
        )
      )
    )
  }
}
