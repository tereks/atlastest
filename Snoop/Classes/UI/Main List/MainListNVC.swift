//
//  MainListNVC.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

open class MainListNVC: UINavigationController {

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topController = topViewController else {
            return .lightContent
        }
        return topController.preferredStatusBarStyle
    }
}
