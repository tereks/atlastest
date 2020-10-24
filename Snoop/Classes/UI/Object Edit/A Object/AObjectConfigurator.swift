//
//  AObjectConfigurator.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AObjectConfigurator {

    class func create(with object: AData?, onSave: AClosure?) -> AObjectVC {
        let viewController = AObjectVC()
        let presenter  = AObjectPresenter(view: viewController)
        let interactor = createInteractor(presenter: presenter, object: object, onSave: onSave)
        let router = AObjectRouter(controller: viewController, mediaPicker: resolve())

        viewController.interactor = interactor
        viewController.router     = router

        return viewController
    }

    private class func createInteractor(presenter: AObjectPresenter,
                                        object: AData?,
                                        onSave: AClosure?) -> AObjectInteractor {
        let dependencies = AObjectInteractor.Dependencies(presenter: presenter,
                                                          object: object,
                                                          textGenerator: resolve())
        let interactor = AObjectInteractor(dependencies: dependencies)
        interactor.onSave = onSave
        return interactor
    }
}
