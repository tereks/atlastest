//
//  AObjectView.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AObjectView: class {

    var interactor: AObjectInteractor! { get set }

    func initialConfigure()

    func setObjectTitle(_ title: String)

    func setObjectDesc(_ desc: String)

    func setValue(_ value: Int)

    func setImage(_ image: UIImage)

    func showLibrary(completion: @escaping PhotosClosure)

    func showMessage(title: String,  message: String, actions: [(String, EmptyClosure?)], addCancel: Bool)

    func close()
}
