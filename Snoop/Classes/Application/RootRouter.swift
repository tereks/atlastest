//
//  RootRouter.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

final class RootRouter: RootRoutable {

    private weak var window: UIWindow?
    private var topViewController: UIViewController {
        guard let window = window else {
            assert(false, "No window object")
            return UIViewController()
        }
        guard let rootViewController = window.rootViewController else {
            assert(false, "No rootViewController")
            return UIViewController()
        }

        if let nvc = rootViewController as? UINavigationController {
            if let topViewController = nvc.topViewController {
                return topViewController
            }
            return nvc
        }
        else {
            return rootViewController
        }
    }

    func configure(window: UIWindow?) {
        self.window = window
    }

    func changeRootController(to viewController: UIViewController, animated: Bool = false) {
        guard animated else {
            self.window?.rootViewController = viewController
            return
        }

        var options = UIWindow.TransitionOptions()
        options.direction = .fade
        options.duration = 0.3
        options.style = .easeOut
        self.window?.setRootViewController(viewController, options: options)
    }
}
