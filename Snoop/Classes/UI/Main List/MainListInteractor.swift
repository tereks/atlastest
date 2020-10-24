//
//  MainListInteractor.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainListInteractor {

    // MARK: - Dependencies

    struct Dependencies {
        let presenter: MainListPresenter
    }

    private var dip: Dependencies

    // MARK: - Life cycle

    init(dependencies: Dependencies) {
        self.dip = dependencies
    }

    func viewDidLoad() {
        dip.presenter.onViewDidLoad()
        dip.presenter.setTitle(Localized.categories())
    }

    func aButtonSelected() {
        dip.presenter.showA()
    }

    func bButtonSelected() {
        dip.presenter.showB()
    }
}
