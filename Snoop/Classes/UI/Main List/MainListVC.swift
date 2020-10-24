//
//  MainListVC.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import TinyConstraints

final class MainListVC: UIViewController, MainListView {

    enum Constants {

        static let buttonHeight: CGFloat = 50

        static let spacerMultiplier: CGFloat = 0.5

        static let buttonInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    // MARK: - Dependencies

    var interactor: MainListInteractor!
    var router: MainListRouter!

    // MARK: - Properties

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let addAButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(Localized.new_a(), for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return view
    }()

    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let addBButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(Localized.new_b(), for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return view
    }()

    // MARK: - Life cycle

	override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func initialConfigure() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        view.addSubview(addAButton)
        view.addSubview(spacerView)
        view.addSubview(addBButton)

        addAButton.addTarget(self, action: #selector(aButtonSelected), for: .touchUpInside)
        addBButton.addTarget(self, action: #selector(bButtonSelected), for: .touchUpInside)
        configureLayout()
    }

    private func configureLayout() {
        tableView.edgesToSuperview(excluding: .bottom)

        addAButton.topToBottom(of: tableView, offset: Constants.buttonInsets.top)
        addAButton.edgesToSuperview(excluding: [.top, .right], insets: Constants.buttonInsets, usingSafeArea: true)
        addAButton.height(Constants.buttonHeight)

        spacerView.leftToRight(of: addAButton)
        spacerView.top(to: addAButton)
        spacerView.bottomToSuperview(offset: -Constants.buttonInsets.bottom)
        spacerView.widthToSuperview(multiplier: Constants.spacerMultiplier)

        addBButton.leftToRight(of: addAButton)
        addBButton.edgesToSuperview(excluding: [.top, .left], insets: Constants.buttonInsets, usingSafeArea: true)
        addBButton.height(Constants.buttonHeight)

        addBButton.width(to: addAButton)
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    @objc private func aButtonSelected() {
        interactor.aButtonSelected()
    }

    @objc private func bButtonSelected() {
        interactor.bButtonSelected()
    }

    func showA(_ object: AData?) {
        router.showA(object)
    }

    func showB(_ object: BData?) {
        router.showB(object)
    }
}
