//
//  MainListPresenter.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainListPresenter {

    fileprivate(set) weak var view: MainListView!

    init(view: MainListView) {
        self.view = view
    }
}

extension MainListPresenter {

    func onViewDidLoad() {
        view.initialConfigure()
    }

    func setTitle(_ title: String) {
        view.setTitle(title)
    }

    func showA(_ object: AData? = nil) {
        view.showA(object)
    }

    func showB(_ object: BData? = nil) {
        view.showB(object)
    }
}
