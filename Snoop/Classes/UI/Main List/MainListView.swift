//
//  MainListView.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainListView: class {

    var interactor: MainListInteractor! { get set }

    func initialConfigure()

    func setTitle(_ title: String)

    func showA(_ object: AData?)

    func showB(_ object: BData?)
}
