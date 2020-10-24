//
//  MainListConfigurator.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainListConfigurator {

    class func createWithNVC() -> MainListNVC {
        let viewController = create()
        return MainListNVC(rootViewController: viewController)
    }

    class func create() -> MainListVC {
        let viewController = MainListVC()
        let presenter = MainListPresenter(view: viewController)
        let interactor = createInteractor(presenter: presenter)
        let router = MainListRouter(controller: viewController)

        viewController.interactor = interactor
        viewController.router     = router

        return viewController
    }

    private class func createInteractor(presenter: MainListPresenter) -> MainListInteractor {
        let dependencies = MainListInteractor.Dependencies(presenter: presenter)
        return MainListInteractor(dependencies: dependencies)
    }
}
