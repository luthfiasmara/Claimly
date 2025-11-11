//
//  Navigator.swift
//  Core
//
//  Created by Luthfi Asmara on 31/07/25.
//


import SwiftUI

public enum NavigationBehavior {
  case push(animated: Bool)
  case present(animated: Bool)
  case replace
  case replaceRoot
}

public protocol Navigator {
  var viewController: UIViewController { get }
  var behavior: NavigationBehavior { get }
}

public protocol InitialNavigator {
  var viewController: UIViewController { get }
}

public extension Navigator {
  func navigate(to: UIViewController, from: UIViewController) {
    switch behavior {
    case .push(let animated):
      from.navigationController?.pushViewController(to, animated: animated)
    case .present(let animated):
      DispatchQueue.main.async {
        from.present(to, animated: animated, completion: nil)
      }
    case .replace:
      DispatchQueue.main.async {
        if var stack = from.navigationController?.viewControllers {
          stack.removeLast()
          stack.append(to)
          from.navigationController?.viewControllers = stack
        }
      }
    case .replaceRoot:
      DispatchQueue.main.async {
        UIApplication.shared.windows.first?.rootViewController = to
      }
    }
  }
  
  func navigate(from viewController: UIViewController) {
    let destination = self.viewController
    navigate(to: destination, from: viewController)
  }
  
  func back(from: UIViewController) {
    switch behavior {
    case .push(let animated):
      from.navigationController?.popViewController(animated: animated)
    case .present(let animated):
      DispatchQueue.main.async {
        from.dismiss(animated: animated, completion: nil)
      }
    case .replace:
      DispatchQueue.main.async {
        from.navigationController?.popViewController(animated: false)
      }
    case .replaceRoot:
      print("Can not back. This is root view controller")
    }
  }
  
  func back<Target: View>(from: UIViewController, to: Target.Type) {
    switch behavior {
    case .push:
      if let toViewController = from.navigationController?.viewControllers.last(where: {
        "\($0.classForCoder))".contains("<\(to)>")
      }) {
        from.navigationController?.popToViewController(toViewController, animated: true)
      } else {
        print("Target view was not found in stack")
      }
    default:
      print("Can not back. Not support to spesific view controller")
    }
  }
  
  func backToRoot(from: UIViewController) {
    switch behavior {
    case .push, .present:
      DispatchQueue.main.async {
        from.navigationController?.popToRootViewController(animated: true)
      }
    default:
      print("Can not back to root.")
    }
  }
}

public extension InitialNavigator {
  func navigate(from window: UIWindow?) {
    window?.rootViewController = viewController
  }
}
