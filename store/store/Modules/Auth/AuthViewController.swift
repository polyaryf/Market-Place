//
//  AuthViewController.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit

class AuthViewController: BaseViewController {
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
        static let textFieldHeight: CGFloat = 50
        static let agreementLabeFontSize: CGFloat = 14
        static let topSpace: CGFloat = 40
        static let textFieldCornerRadius: CGFloat = 15
    }
    var authPresenter: AuthPresenter
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
    private lazy var authLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 40)
        label.text = Text.Auth.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Auth.login
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
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Auth.forgetPassword, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return button
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        forgetPasswordButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
//        let authPresenter = AuthPresenter(keychainService: KeychainService())
//        print(authPresenter.saveToken(token: "io12345", emailOrPhoneNumber: emailPhoneTextField.text ?? ""))
//        print(authPresenter.getToken(emailOrPhoneNumber: emailPhoneTextField.text ?? ""))
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
//        navigationItem.hidesBackButton = true
        passwordTextField.delegate = self
        emailPhoneTextField.delegate = self
        view.addSubview(authLabel)
        view.addSubview(passwordTextField)
        view.addSubview(emailPhoneTextField)
        view.addSubview(nextButton)
        view.addSubview(loginLabel)
        view.addSubview(forgetPasswordButton)
        setupConstraints()
    }
    private func setupConstraints() {
        authLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.topSpace)
            make.leading.equalToSuperview().offset(UIConstants.contentInset + 5)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 100)
        }
        emailPhoneTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authLabel.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailPhoneTextField.snp.bottom).offset(UIConstants.spaceBetweenTextFields)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(UIConstants.contentInset)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(3 * UIConstants.contentInset
                                                                         + nextButton.frame.height / 3)
            make.trailing.equalTo(nextButton.snp.leading).offset(-2 * UIConstants.contentInset)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(3 * UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(2 * UIConstants.contentInset)
            make.width.height.equalTo(54)
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
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
        checkIfEnteredDataCorrect(emailOrPhone: emailPhoneTextField.text ?? "", password: passwordTextField.originalText ?? "")
    }
    private func checkIfEnteredDataCorrect(emailOrPhone: String, password: String) {
        if (authPresenter.validator.validateEmail(email: emailOrPhone)
            || authPresenter.validator.validatePhoneNumber(number: emailOrPhone))
            && authPresenter.validator.validatePassword(password: password) {
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
