//
//  ApplicationNavCoordinator.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

final class ApplicationNavCoordinator {

    struct Dependencies {
        let router: RootRoutable
    }
    private var dip: Dependencies

    init(dependencies: Dependencies) {
        self.dip = dependencies
    }

    func applicationLaunched() {
        showMainScreen()
    }

    private func showMainScreen() {
        let mainVC = MainListConfigurator.createWithNVC()
        dip.router.changeRootController(to: mainVC)
    }
}
