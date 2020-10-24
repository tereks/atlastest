//
//  AObjectInteractor.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AObjectInteractor {

    enum Constants {

        static let maxTitleLength: Int = 50

        static let maxDescLength: Int = 300

        static let photoLib = "NSPhotoLibraryUsageDescription"
    }

    // MARK: - Dependencies

    struct Dependencies {
        let presenter: AObjectPresenter
        let object: AData?
        let textGenerator: TextGenerator
    }
    private var dip: Dependencies

    var onSave: AClosure?

    // MARK: - Life cycle

    init(dependencies: Dependencies) {
        self.dip = dependencies
    }

    func viewDidLoad() {
        dip.presenter.onViewDidLoad()

        if dip.object == nil {
            configureRandomData()
        }
    }

    func configureRandomData() {
        let title = dip.textGenerator.randomString(maxLength: Constants.maxTitleLength)
        dip.presenter.setObjectTitle(title)

        let desc = dip.textGenerator.randomString(maxLength: Constants.maxDescLength)
        dip.presenter.setObjectDesc(desc)

        let value = Int.random(in: 0..<100)
        dip.presenter.setValue(value)
    }

    func addImageButtonSelected() {
        dip.presenter.showLibrary() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let images):
                guard !images.isEmpty else {
                    return
                }
                self.dip.presenter.setImage(images.first!)

            case .failure(let error):
                let title: String = Bundle.main.object(forInfoDictionaryKey: Constants.photoLib) as? String ?? ""
                let changeSettingsAction: EmptyClosure = {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                let actions: [(String, EmptyClosure?)] = [(Localized.change_settings(), changeSettingsAction)]
                self.dip.presenter.showMessage(title: title,
                                               message: error.localizedDescription,
                                               actions: actions,
                                               addCancel: true)
            }
        }
    }

    func save(title: String, desc: String, value: Int, image: UIImage?) {
        let object = AData(title: title, desc: desc, value: value, image: image)
        onSave?(object)
        dip.presenter.close()
    }
}
