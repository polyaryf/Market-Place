//
//  DeliveryViewController.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

protocol DeliveryViewOutput {
    func viewDidTapToPassDeliveryData(country: String, city: String, street: String, building: String)
}

class DeliveryViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let checkBoxWidthHeight: CGFloat = 30
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 65
        static let textFieldWidth: CGFloat = 330
        static let textFieldHeight: CGFloat = 50
    }
    var presenter: OrderPresenter
    init(presenter: OrderPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Order.Delivery.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var countryTextField: UITextField = {
        let textField = RegularTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Order.Delivery.country
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var cityTextField: UITextField = {
        let textField = RegularTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Order.Delivery.city
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var streetTextField: UITextField = {
        let textField = RegularTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Order.Delivery.street
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var homeTextField: UITextField = {
        let textField = RegularTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Order.Delivery.home
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var nextButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Order.Delivery.next)
        button.backgroundColor = UIColor(named: "baseButtonColor")
        return button
    }()
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func isTextFieldsEmpty(textFields: [UITextField]) -> Bool {
        var isCorrect = false
        textFields.forEach { textField in
            if textField.text == "" {
                isCorrect = true
            }
        }
        return isCorrect
    }
    @objc func nextButtonTapped() {
        if isTextFieldsEmpty(textFields: [countryTextField, cityTextField, streetTextField, homeTextField]) {
            countryTextField.layer.borderColor = UIColor.systemRed.cgColor
            countryTextField.layer.borderWidth = 1.0
            cityTextField.layer.borderColor = UIColor.systemRed.cgColor
            cityTextField.layer.borderWidth = 1.0
            streetTextField.layer.borderColor = UIColor.systemRed.cgColor
            streetTextField.layer.borderWidth = 1.0
            homeTextField.layer.borderColor = UIColor.systemRed.cgColor
            homeTextField.layer.borderWidth = 1.0
        } else {
            presenter.viewDidTapToPassDeliveryData(country: countryTextField.text ?? "",
                                                   city: cityTextField.text ?? "",
                                                   street: streetTextField.text ?? "",
                                                   building: homeTextField.text ?? "")
        }
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        [deliveryLabel, countryTextField, cityTextField, streetTextField, homeTextField, nextButton].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
            make.width.equalTo(UIConstants.textFieldWidth)
        }
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(countryTextField.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
            make.width.equalTo(UIConstants.textFieldWidth)
        }
        streetTextField.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
            make.width.equalTo(UIConstants.textFieldWidth)
        }
        homeTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
            make.width.equalTo(UIConstants.textFieldWidth)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(homeTextField.snp.bottom).offset(4 * UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(2 * UIConstants.contentInset)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
}
