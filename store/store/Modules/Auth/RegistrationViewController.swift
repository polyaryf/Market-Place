//
//  ViewController.swift
//  store
//
//  Created by Evelina on 30.06.2023.
//

import UIKit
import SnapKit

protocol RegistrationViewOutput {
    func viewDidTapToRegister(login: String, password: String, role: String)
}

class RegistrationViewController: BaseViewController {

    // MARK: - Private constants
    private enum UIConstants {
        static let titleLabelFontSize: CGFloat = 40
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 16
        static let textFieldWidth: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 18
        static let spaceBetweenTextFields: CGFloat = 25
        static let spaceAfterInfoLabel: CGFloat = 36
        static let buttonBorderWidth: CGFloat = 2
        static let textFieldHeight: CGFloat = 50
        static let bottomtConstaint: CGFloat = 24
        static let agreementLabeFontSize: CGFloat = 14
        static let topSpace: CGFloat = 40
        static let textFieldCornerRadius: CGFloat = 15
    }
    var authPresenter: AuthPresenter
    // MARK: - Init
    init(presenter: AuthPresenter) {
        self.authPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
//        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.placeholder = Text.Registration.password
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.setImagetoLeft(image: UIImage(named: "passwordIcon") ?? UIImage(), pointX: 8, pointY: 10, width: 22, height: 25)
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var confirmPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
//        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.placeholder = Text.Registration.confirmationPassword
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.setImagetoLeft(image: UIImage(named: "passwordIcon") ?? UIImage(), pointX: 8, pointY: 10, width: 22, height: 25)
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var emailPhoneTextField: UITextField = {
        let textField = TextFieldWithIcon()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Registration.emailPhone
        textField.setImagetoLeft(image: UIImage(named: "personIcon") ?? UIImage(), pointX: 5, pointY: 10, width: 29, height: 27)
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 40)
        label.text = Text.Registration.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var isAdminLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        label.text = "Я продавец"
        label.textColor = UIColor(named: "greenColor")
        return label
    }()
    private lazy var roleSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    private lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Registration.signup
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 54, height: 54)
        button.backgroundColor = UIColor(named: "baseButtonColor")
        button.layer.cornerRadius = button.frame.width / 2
//        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setImage(UIImage(named: "forwardArrow"), for: .normal)
        return button
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
        // TODO: отправка запроса на сервер - проверка, что все поля заполнены
        if !isDataCorrect(emailOrPhone: emailPhoneTextField.text ?? "",
                         password: passwordTextField.originalText ?? "",
                         confirmedPassword: confirmPasswordTextField.originalText ?? "") {
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.borderWidth = 1.0
            emailPhoneTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailPhoneTextField.layer.borderWidth = 1.0
            confirmPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            confirmPasswordTextField.layer.borderWidth = 1.0
        } else {
            var role: String = ""
            switch roleSwitch.isOn {
            case true: role = "admin"
            case false: role = "customer"
            }
            authPresenter.viewDidTapToRegister(login: emailPhoneTextField.text ?? "",
                                               password: passwordTextField.originalText ?? "",
                                               role: role)
        }
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
//        navigationItem.hidesBackButton = true
        passwordTextField.delegate = self
        emailPhoneTextField.delegate = self
        confirmPasswordTextField.delegate = self
        view.addSubview(registrationLabel)
        view.addSubview(passwordTextField)
        view.addSubview(emailPhoneTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(nextButton)
        view.addSubview(signupLabel)
        [isAdminLabel, roleSwitch].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        registrationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.topSpace)
            make.trailing.leading.equalToSuperview().offset(UIConstants.contentInset + 5)
        }
        emailPhoneTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registrationLabel.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailPhoneTextField.snp.bottom).offset(UIConstants.spaceBetweenTextFields)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        confirmPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(UIConstants.spaceBetweenTextFields)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        isAdminLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(2 * UIConstants.contentInset)
            make.leading.equalToSuperview().inset(2 * UIConstants.contentInset)
        }
        roleSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(isAdminLabel.snp.centerY)
            make.leading.equalTo(isAdminLabel.snp.trailing).offset(UIConstants.contentInset)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5 * UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(2 * UIConstants.contentInset)
            make.width.height.equalTo(54)
        }
        signupLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nextButton.snp.centerY)
            make.trailing.equalTo(nextButton.snp.leading).offset(-UIConstants.contentInset)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if type(of: textField) == PasswordTextField.self {
            guard let passwordTextField: PasswordTextField = textField as? PasswordTextField else {return true}
            if string == "" {
                passwordTextField.originalText?.removeLast()
            } else {
                passwordTextField.originalText?.append(string)
            }
            if passwordTextField.isShowPassword {
                textField.text = passwordTextField.originalText
            } else {
                textField.text = String(repeating: "*", count: passwordTextField.originalText?.count ?? 0)
            }
            return false
        }
       return true
    }
    private func formatPhoneNumber(textField: UITextField) {
        var currentText = textField.text ?? ""
        if currentText.count == 6 {
            currentText.insert(" ", at: currentText.index(currentText.startIndex, offsetBy: 6))
        }
        if currentText.count == 10 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 10))
        }
        if currentText.count == 13 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 13))
        }
        textField.text = currentText
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
        checkIfEnteredDataCorrect(emailOrPhone: emailPhoneTextField.text ?? "",
                                  password: passwordTextField.originalText ?? "",
                                  confirmedPassword: confirmPasswordTextField.originalText ?? "")
    }
    private func isDataCorrect(emailOrPhone: String, password: String, confirmedPassword: String) -> Bool {
        if (authPresenter.validator.validateEmail(email: emailOrPhone)
            || authPresenter.validator.validatePhoneNumber(number: emailOrPhone))
            && authPresenter.validator.validatePassword(password: password)
            && (password == confirmedPassword) {
            return true
        } else {
            return false
        }
    }
    private func checkIfEnteredDataCorrect(emailOrPhone: String, password: String, confirmedPassword: String) {
        if (isDataCorrect(emailOrPhone: emailOrPhone, password: password, confirmedPassword: confirmedPassword)) {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "greenColor")
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "baseButtonColor")
            }
        }
    }
}
