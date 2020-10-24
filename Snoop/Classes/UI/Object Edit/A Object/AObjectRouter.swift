//
//  AObjectRouter.swift
//  Snoop
//
//  Created by Sergey Kim on 20.10.2020.
//

import UIKit

final class AObjectRouter {

    weak var viewController: UIViewController!
    let mediaPicker: MediaProvider

    var nvc: UINavigationController? {
        return viewController.navigationController
    }

    init(controller: UIViewController, mediaPicker: MediaProvider) {
        self.viewController = controller
        self.mediaPicker    = mediaPicker
    }

    func getImagesFromLibrary(completion: @escaping PhotosClosure) {
        mediaPicker.getImagesFromLibrary(presentationController: viewController, completion: completion)
    }
}
