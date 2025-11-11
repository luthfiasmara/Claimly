//
//  CommonLoadingView.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 11/11/25.
//

import UIKit

public class CommonLoadingView {
  
  private var loadingQueueCounter: Int {
    var counter = 0
    currentWindow { window in
      window.subviews.forEach { view in
        if view.isKind(of: QueueView.self) {
          counter += 1
        }
      }
    }
    return counter
  }
  
  private let widthHeight: CGFloat = 100
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  private var backgroundCover: UIView
  private let queueView = QueueView()
  
  public init() {
    backgroundCover = UIView()
    backgroundCover.backgroundColor = .clear
    activityIndicator.color = .white
    activityIndicator.hidesWhenStopped = true
  }
  
  public func show(backgroundColor: UIColor = .black.withAlphaComponent(0.25)) {
    currentWindow { window in
      window.addSubview(queueView)
    }
    
    if loadingQueueCounter > 1 {
      return
    }
    
    currentWindow { window in
      backgroundCover = UIView(frame: window.bounds)
      backgroundCover.backgroundColor = backgroundColor
      backgroundCover.tag = ViewTags.backgroundCover
      window.addSubview(backgroundCover)
      
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      backgroundCover.addSubview(activityIndicator)
      activityIndicator.startAnimating()
      
      NSLayoutConstraint.activate([
        activityIndicator.widthAnchor.constraint(equalToConstant: widthHeight),
        activityIndicator.heightAnchor.constraint(equalToConstant: widthHeight),
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundCover.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: backgroundCover.centerYAnchor)
      ])
      
      animateView()
    }
  }
  
  private func animateView() {
    activityIndicator.alpha = 0
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
      self.activityIndicator.alpha = 1
    }
  }
  
  func currentWindow(window: (UIWindow) -> Void) {
    let activeWindow = UIApplication
      .shared
      .connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) }
      .first
    
    if let activeWindow = activeWindow {
      window(activeWindow)
    }
  }
  
  public func dismiss(willDismissQueue: Bool) {
    currentWindow { window in
      if willDismissQueue {
        window.subviews.forEach { view in
          if view.isKind(of: QueueView.self) {
            view.removeFromSuperview()
          }
        }
      } else {
        window.subviews.first(where: { $0.isKind(of: QueueView.self) })?.removeFromSuperview()
      }
      if loadingQueueCounter == 0 {
        if let backgroundCover = window.viewWithTag(ViewTags.backgroundCover) {
          backgroundCover.removeFromSuperview()
        }
      }
    }
  }
}

// MARK: - Identifier View
fileprivate class QueueView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

fileprivate struct ViewTags {
  static let backgroundCover = 99999
}
