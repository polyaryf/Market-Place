//
//  AddProductInfoViewController.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import UIKit

enum AddProductInfoViewControllerState {
    case enterCost
    case enterName
}
protocol AddProductInfoViewOutput {
    func viewDidTapToAddDescription()
    func viewDidTapToReturnToProducts()
}

class AddProductInfoViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let textFieldWidth: CGFloat = 350
        static let textFieldHeight: CGFloat = 50
    }
    var state: AddProductInfoViewControllerState
    var presenter: AdminPresenter
    init(presenter: AdminPresenter, state: AddProductInfoViewControllerState) {
        self.presenter = presenter
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 23)
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var textField: UITextField = {
        let textField = RegularTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Filter.cancel, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Montserrat", size: 18) ?? UIFont()
        return button
    }()
    private lazy var nextButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.continue)
        button.backgroundColor = UIColor(named: "baseButtonColor")
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @objc func nextButtonTapped() {
        if textField.text == "" {
            textField.layer.borderColor = UIColor.systemRed.cgColor
            textField.layer.borderWidth = 1.0
        }
        switch state {
        case .enterCost:
            presenter.viewDidTapToReturnToProducts()
        case .enterName:
            presenter.viewDidTapToAddDescription()
        }
    }
    // MARK: - Private functions
    private func configure() {
        switch state {
        case .enterCost:
            infoLabel.text = Text.Admin.CreateProduct.AddCost.title
            textField.placeholder = Text.Admin.CreateProduct.AddCost.placeholder
        case .enterName:
            infoLabel.text = Text.Admin.CreateProduct.AddName.title
            textField.placeholder = Text.Admin.CreateProduct.AddName.placeholder
        }
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        textField.delegate = self
        configure()
        [cancelButton, infoLabel, textField, nextButton].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 5)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset + 4)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
    }
}
extension AddProductInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch state {
        case .enterCost:
            let allowedCharacters = "1234567890"
            let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            if (typedCharcterSet.isSubset(of: allowedCharcterSet)) {
                return true
            } else {
                return false
            }
        case .enterName:
            let allowedCharacters = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя"
            let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            if (typedCharcterSet.isSubset(of: allowedCharcterSet)) {
                return true
            } else {
                return false
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "greenColor")?.cgColor
        textField.layer.borderWidth = 1.3
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "greenColor")
            }
            textField.layer.borderColor = UIColor(named: "greenColor")?.cgColor
            textField.layer.borderWidth = 1.3
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "baseButtonColor")
            }
            textField.layer.borderColor = UIColor.systemGray5.cgColor
            textField.layer.borderWidth = 0.5
        }
    }
}
