//
//  ViewWrapper.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 31/07/25.
//

import Common
import Core
import Combine
import SwiftUI
import UIKit
import SnapKit

public class WrapperHolder {
  public weak var viewController: UIViewController?
    
  public init() {}
}

public protocol WrappedView: View {
  var holder: WrapperHolder { get set }
  var disabledBackGesture: Bool { get }
  
  func willPop() -> Bool
  
  // Navigation Bar
  func configureNavigationBar(viewController: UIViewController)
  func onLeftNavigationBarButtonTapped()
  func onRightNavigationBarFirstButtonTapped()
  func onRightNavigationBarSecondButtonTapped()
  func onSearchBarClicked()
  func onSearchBarValueChanged(searchBar: UISearchBar, text: String?)
  func onSearchBarSearchButtonClicked(text: String?)
  
  func checkInternetConnection()
  func showNoInternetView()
  func hideNoInternetView()
  func showNoDataView()
}

public extension WrappedView {
  var viewController: UIViewController {
    let viewController = ViewWrapper(rootView: self)
    self.holder.viewController = viewController
    return viewController
  }
  var disabledBackGesture: Bool {
    false
  }
  
  func willPop() -> Bool { true }
  
  func configureNavigationBar(viewController: UIViewController) {}
  func onLeftNavigationBarButtonTapped() {}
  func onRightNavigationBarFirstButtonTapped() {}
  func onRightNavigationBarSecondButtonTapped() {}
  func onSearchBarClicked() {}
  func onSearchBarValueChanged(searchBar: UISearchBar, text: String?) {}
  func onSearchBarSearchButtonClicked(text: String?) {}
  
  func checkInternetConnection() { }
  func showNoInternetView() {
    (self.holder.viewController as? ViewWrapper<Self>)?.showNoInternetView()
  }
  
  func hideNoInternetView() {
    (self.holder.viewController as? ViewWrapper<Self>)?.hideNoInternetView()
  }
  
  func showNoDataView() {
    (self.holder.viewController as? ViewWrapper<Self>)?.showNoDataView()
  }
}

public class ViewWrapper<SomeView>: UIHostingController<SomeView>, UIGestureRecognizerDelegate, UINavigationControllerDelegate where SomeView: WrappedView {
  
  private lazy var emptyStateView: UIView = {
    let view = UIView()
    view.layer.zPosition = 9999999
    view.backgroundColor = theme.colors.light.uiColor
    view.isHidden = true
    
    return view
  }()
  
  private lazy var fillerColorView: UIView = {
    let view = UIView()
    view.backgroundColor = theme.colors.light.uiColor
    return view
  }()
  
  private lazy var fillerView: UIView = {
    let view = UIView()
    view.layer.zPosition = 9999998
    view.backgroundColor = .clear
    view.isUserInteractionEnabled = false
    view.isHidden = true
    return view
  }()
  
  private var cancellables: Set<AnyCancellable> = []
  
  public override func viewWillAppear(_ animated: Bool) {
    self.view.backgroundColor = .white
    super.viewWillAppear(animated)
    self.rootView.configureNavigationBar(viewController: self)
    // MARK: - Enable interactive pop gesture (swipe)
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    
    if let navController = getNavigationController() {
        navController.delegate = self
        navController.interactivePopGestureRecognizer?.delegate = self
    }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  public override func viewDidLayoutSubviews() {
    view.addSubview(fillerView)
    fillerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.width.equalToSuperview()
    }
  }
  
  // Helper function to get the UINavigationController
  public func getNavigationController() -> UINavigationController? {
    guard let window = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }),
          let rootViewController = window.rootViewController else {
      return nil
    }

      if let navController = rootViewController as? UINavigationController {
          return navController
      } else if let tabController = rootViewController as? UITabBarController {
          return tabController.selectedViewController as? UINavigationController
      } else if let presented = rootViewController.presentedViewController as? UINavigationController {
          return presented
      }
      return nil
  }
  
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    let viewControllers = navigationController.viewControllers
    let disabledBackGesture = (rootView as (any WrappedView)).disabledBackGesture
    navigationController.interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1 && !disabledBackGesture
  }

  public func onLeftNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    rootView.onLeftNavigationBarButtonTapped()
  }

  public func onRightNavigationBarFirstButtonTapped(sender: UIBarButtonItem?) {
    rootView.onRightNavigationBarFirstButtonTapped()
  }
  public func onRightNavigationBarSecondButtonTapped(sender: UIBarButtonItem?) {
    rootView.onRightNavigationBarSecondButtonTapped()
  }

  public func onSearchBarClicked() {
    rootView.onSearchBarClicked()
  }

  public func onSearchBarValueChanged(searchBar: UISearchBar, text: String?) {
    rootView.onSearchBarValueChanged(searchBar: searchBar, text: text)
  }

  public func onSearchBarSearchButtonClicked(text: String?) {
    rootView.onSearchBarSearchButtonClicked(text: text)
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return (rootView as (any WrappedView)).willPop()
  }
}

public extension ViewWrapper {
  func showNoInternetView() { }
  
  func hideNoInternetView() { }
  
  func showNoDataView() { }
}

public struct DataStateModifier<TheValue>: ViewModifier {
  var state: DataState<TheValue>
  var onSuccess: ((TheValue) -> Void)?
  var onFailed: ((Error) -> Void)?
  
  init(state: DataState<TheValue>,
       onSuccess: ((TheValue) -> Void)? = nil,
       onFailed: ((Error) -> Void)? = nil) {
    self.state = state
    self.onSuccess = onSuccess
    self.onFailed = onFailed
  }
  
  public func body(content: Content) -> some View {
    switch state {
    case .loading:
      content
    case .success(let data):
      let _ = onSuccess?(data)
      content
    case .failed(let error):
      let _ = onFailed?(error)
      content
    default:
      content
    }
  }
}

struct PublishedDataStateModifier<TheValue>: ViewModifier {
    var data: Published<DataState<TheValue>>.Publisher
    var onSuccess: ((TheValue) -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onFailed: ((Error) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(data) { state in
                switch state {
                case .success(let value):
                    onLoading?(false)
                    onSuccess?(value)
                case .loading:
                    onLoading?(true)
                case .failed(let error):
                    onLoading?(false)
                    onFailed?(error)
                default:
                  onLoading?(false)
                }
            }
    }
}

public extension View {
  func dataState<TheValue>(state: DataState<TheValue>,
                           onSuccess: ((TheValue) -> Void)? = nil,
                           onFailed: ((Error) -> Void)? = nil) -> some View {
    modifier(DataStateModifier(state: state,
                               onSuccess: onSuccess,
                               onFailed: onFailed))
  }
  
  func dataState<TheValue>(
    _ data: Published<DataState<TheValue>>.Publisher,
    onSuccess: ((TheValue) -> Void)? = nil,
    onLoading: ((Bool) -> Void)? = nil,
    onFailed: ((Error) -> Void)? = nil
  ) -> some View {
    modifier(PublishedDataStateModifier(data: data, onSuccess: onSuccess, onLoading: onLoading, onFailed: onFailed))
  }
}

