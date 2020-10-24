//
//  MainListRouter.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

final class MainListRouter {

    weak var viewController: UIViewController!

    var nvc: UINavigationController? {
        return viewController.navigationController
    }

    init(controller: UIViewController) {
        self.viewController = controller
    }

    func showA(_ object: AData?, onSave: AClosure? = nil) {
        let favourites = AObjectConfigurator.create(with: object, onSave: onSave)
        nvc?.pushViewController(favourites, animated: true)
    }

    func showB(_ object: BData?) {
        
    }
}
