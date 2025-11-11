//
//  Theme.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//

import SwiftUI
import Combine

enum ThemeType: String, CaseIterable {
  case light = "Light"
  case dark = "Dark"
  case system = "System"
}

public protocol Theme {
  /// Not ready yet, because Figma hasn't implemented Design Tokens yet
  var colors: Colors { get }
  var typography: Typography { get }
}

final class AdaptiveTheme: Theme, ObservableObject {
  @Published var themeType: ThemeType {
    didSet {
      updateTheme()
      saveThemePreference()
    }
  }
  
  private var lightTheme = LightTheme()
  private var darkTheme = DarkTheme()
  private let userDefaults = UserDefaults.standard
  private let themeKey = "selectedTheme"
  
  // MARK: - Computed Properties (Proxy to actual themes)
  private var activeTheme: Theme {
    switch themeType {
    case .light:
      return lightTheme
    case .dark:
      return darkTheme
    case .system:
      return isSystemDark ? darkTheme : lightTheme
    }
  }
  
  private var isSystemDark: Bool {
    return UITraitCollection.current.userInterfaceStyle == .dark
  }
  
  var colors: Colors { activeTheme.colors }
  var typography: Typography { activeTheme.typography }
  
  init() {
    UIFont.loadCustomFont()
    
    let savedTheme = userDefaults.string(forKey: themeKey) ?? ThemeType.system.rawValue
    self.themeType = ThemeType(rawValue: savedTheme) ?? .system
    
    setupSystemThemeObservation()
  }
  
  private func updateTheme() {
    objectWillChange.send()
  }
  
  private func saveThemePreference() {
    userDefaults.set(themeType.rawValue, forKey: themeKey)
  }
  
  private func setupSystemThemeObservation() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(systemThemeChanged),
      name: UIApplication.didBecomeActiveNotification,
      object: nil
    )
  }
  
  @objc private func systemThemeChanged() {
    if themeType == .system {
      updateTheme()
    }
  }
  
  func setLight() {
    themeType = .light
  }
  
  func setDark() {
    themeType = .dark
  }
  
  func setSystem() {
    themeType = .system
  }
  
  func toggle() {
    switch themeType {
    case .light:
      setDark()
    case .dark:
      setLight()
    case .system:
      setLight()
    }
  }
}

@MainActor
public final class Themes {
  static let adaptiveTheme = AdaptiveTheme()
  
  public static var current: CurrentValueSubject<Theme, Never> = .init(adaptiveTheme)

  public static func setCurrent(theme: Theme) {
    Self.current.send(theme)
  }

  public static func setLight() {
    adaptiveTheme.setLight()
    setCurrent(theme: adaptiveTheme)
  }

  public static func setDark() {
    adaptiveTheme.setDark()
    setCurrent(theme: adaptiveTheme)
  }

  public static func setSystem() {
    adaptiveTheme.setSystem()
    setCurrent(theme: adaptiveTheme)
  }

  public static func toggle() {
    adaptiveTheme.toggle()
    setCurrent(theme: adaptiveTheme)
  }
}

