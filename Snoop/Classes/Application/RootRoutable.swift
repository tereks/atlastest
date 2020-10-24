//
//  RootRoutable.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import Foundation
import UIKit

public protocol RootRoutable {

    func configure(window: UIWindow?)

    func changeRootController(to viewController: UIViewController, animated: Bool)
}

public extension RootRoutable {

    func changeRootController(to viewController: UIViewController, animated: Bool = true) {
        changeRootController(to: viewController, animated: animated)
    }
}
