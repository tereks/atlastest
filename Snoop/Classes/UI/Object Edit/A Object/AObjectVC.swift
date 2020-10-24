//
//  AObjectVC.swift
//  Snoop
//
//  Created Sergey Kim on 19.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AObjectVC: UIViewController, AObjectView, UITextFieldDelegate {

    enum Constants {

        static let cornerRadius: CGFloat = 5

        static let textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        static let placeholderColor: UIColor = .lightGray

        static let imageOffset: CGFloat = 50

        static let imageSize: CGFloat = 130
        static let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        static let descHeight: CGFloat = 80
    }

    // MARK: - Dependencies

    var interactor: AObjectInteractor!
    var router: AObjectRouter!

    // MARK: - Properties

    let addImageButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(R.image.add_image(), for: .normal)
        return view
    }()

    let titleEdit: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.font = UIFont.systemFont(ofSize: 15)
        view.tintColor = .black
        view.textColor = .black
        view.placeholder = Localized.title()
        view.keyboardType = .default
        view.returnKeyType = .next
        view.autocorrectionType = .no
        return view
    }()

    let descEdit: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.text = Localized.description()
        view.textColor = Constants.placeholderColor
        view.textContainerInset = Constants.textContainerInset
        view.layer.cornerRadius = Constants.cornerRadius
        view.keyboardType = .default
        view.autocorrectionType = .no
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    let valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()

    let stepper: UIStepper = {
        let view = UIStepper()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.value = 0
        view.stepValue = 1
        return view
    }()

    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
        tap.numberOfTapsRequired = 1
        return tap
    }()

    private var value: Int = 0 {
        didSet {
            value = max(0, value)
            valueLabel.text = Localized.value(value)
        }
    }

    // MARK: - Life cycle

	override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func initialConfigure() {
        view.backgroundColor = .white

        view.addSubview(addImageButton)
        view.addSubview(titleEdit)
        view.addSubview(descEdit)
        view.addSubview(valueLabel)
        view.addSubview(stepper)

        view.addGestureRecognizer(tap)

        value = 0

        titleEdit.delegate = self

        addImageButton.addTarget(self, action: #selector(addImageButtonSelected), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)

        configureLayout()
        configureNavigationBar()
    }

    private func configureLayout() {
        addImageButton.topToSuperview(offset: Constants.imageOffset, usingSafeArea: true)
        addImageButton.aspectRatio(1)
        addImageButton.width(Constants.imageSize)
        addImageButton.centerXToSuperview()

        titleEdit.topToBottom(of: addImageButton, offset: Constants.insets.top)
        titleEdit.edgesToSuperview(excluding: [.top, .bottom], insets: Constants.insets)

        descEdit.topToBottom(of: titleEdit, offset: Constants.insets.top)
        descEdit.edgesToSuperview(excluding: [.top, .bottom], insets: Constants.insets)
        descEdit.height(Constants.descHeight)

        valueLabel.topToBottom(of: descEdit, offset: Constants.insets.top)
        valueLabel.leftToSuperview(offset: Constants.insets.left)
        valueLabel.height(to: stepper)

        stepper.leftToRight(of: valueLabel)
        stepper.top(to: valueLabel)
        stepper.rightToSuperview(offset: -Constants.insets.right)
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localized.save(), style: .plain, target: self, action: #selector(saveSelected))
    }

    @objc
    func stepperValueChanged() {
        self.value = Int(stepper.value)
    }

    @objc
    func tapRecognized() {
        view.endEditing(true)
    }

    @objc
    func addImageButtonSelected() {
        interactor.addImageButtonSelected()
    }

    @objc
    func saveSelected() {
        interactor.save(title: titleEdit.text ?? "",
                        desc: descEdit.text ?? "",
                        value: value,
                        image: addImageButton.image(for: .normal))
    }


    func setObjectTitle(_ title: String) {
        titleEdit.text = title
    }

    func setObjectDesc(_ desc: String) {
        descEdit.text = desc
    }

    func setValue(_ value: Int) {
        self.value = value
        stepper.value = Double(value)
    }

    func setImage(_ image: UIImage) {
        addImageButton.setImage(image, for: .normal)
    }


    func showLibrary(completion: @escaping PhotosClosure) {
        router.getImagesFromLibrary(completion: completion)
    }

    func showMessage(title: String,  message: String, actions: [(String, EmptyClosure?)], addCancel: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action.0, style: .default) { _ in
                action.1?()
            }
            alert.addAction(alertAction)
        }

        if addCancel {
            let cancelAction = UIAlertAction(title: Localized.cancel(), style: .cancel) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancelAction)
        }
        self.present(alert, animated: true, completion: nil)
    }

    func close() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === titleEdit {
            titleEdit.resignFirstResponder()
            descEdit.becomeFirstResponder()
        }
        return true
    }
}
