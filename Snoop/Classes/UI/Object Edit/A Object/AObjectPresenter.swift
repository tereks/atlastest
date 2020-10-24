//
//  AObjectPresenter.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AObjectPresenter {

    fileprivate(set) weak var view: AObjectView!

    init(view: AObjectView) {
        self.view = view
    }
}

extension AObjectPresenter {

    func onViewDidLoad() {
        view.initialConfigure()
    }

    func setObjectTitle(_ title: String) {
        view.setObjectTitle(title)
    }

    func setObjectDesc(_ desc: String) {
        view.setObjectDesc(desc)
    }

    func setValue(_ value: Int) {
        view.setValue(value)
    }

    func setImage(_ image: UIImage) {
        view.setImage(image)
    }

    func showLibrary(completion: @escaping PhotosClosure) {
        view.showLibrary(completion: completion)
    }

    func showMessage(title: String,  message: String, actions: [(String, EmptyClosure?)], addCancel: Bool) {
        view.showMessage(title: title,  message: message, actions: actions, addCancel: addCancel)
    }

    func close() {
        view.close()
    }
}
