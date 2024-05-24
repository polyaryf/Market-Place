//
//  StartViewController.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit

protocol StartViewOutput {
    func viewDidTapToRegistrationScreen()
    func viewDidTapToAutorizationScreen()
}

class StartViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let buttonCornerRadius: CGFloat = 20
        static let contentInset: CGFloat = 16
        static let buttonLabelFontSize: CGFloat = 18
        static let titleLabelFontSize: CGFloat = 40
        static let topOffset: CGFloat = 150
        static let bottomInset: CGFloat = 70
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
    private lazy var appIconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "appIcon")
        return image
    }()
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: UIConstants.titleLabelFontSize)
        label.text = Text.Start.appName
        label.textColor = UIColor(named: "greenColor")
        return label
    }()
    private lazy var appSloganLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 16)
        label.text = Text.Start.appSlogan
        label.textColor = UIColor(named: "baseButtonColor")
        return label
    }()
    private lazy var toSignupScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Start.signup, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 20) ?? UIFont()
        return button
    }()
    private lazy var toCatalogScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Start.catalogTransition, for: .normal)
        button.setTitleColor(UIColor(named: "placeholderTextColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-Medium", size: 16) ?? UIFont()
        return button
    }()
    private lazy var toLoginScreenButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(Text.Start.login, for: .normal)
        button.backgroundColor = UIColor(named: "greenColor")
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: 4 * UIConstants.contentInset, bottom: UIConstants.contentInset, right: 4 * UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 20) ?? UIFont()
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        toSignupScreenButton.addTarget(self, action: #selector(toSignupScreenButtonTapped), for: .touchUpInside)
        toCatalogScreenButton.addTarget(self, action: #selector(toCatalogScreenButtonTapped), for: .touchUpInside)
        toLoginScreenButton.addTarget(self, action: #selector(toLoginScreenButtonTapped), for: .touchUpInside)
    }
    @objc func toSignupScreenButtonTapped() {
        authPresenter.viewDidTapToRegistrationScreen()
    }
    @objc func toLoginScreenButtonTapped() {
        authPresenter.viewDidTapToRegistrationScreen()
    }
    @objc func toCatalogScreenButtonTapped() {
        
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
//        navigationItem.hidesBackButton = true
        view.addSubview(appIconImageView)
        view.addSubview(appNameLabel)
        view.addSubview(appSloganLabel)
        view.addSubview(toSignupScreenButton)
        view.addSubview(toLoginScreenButton)
        view.addSubview(toCatalogScreenButton)
        setupConstraints()
    }
    private func setupConstraints() {
        appIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIConstants.topOffset)
            make.width.equalTo(200)
            make.height.equalTo(150)
        }
        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appIconImageView.snp.bottom).offset(2.5 * UIConstants.contentInset)
        }
        appSloganLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(UIConstants.contentInset)
        }
        toCatalogScreenButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIConstants.bottomInset)
            make.centerX.equalToSuperview()
        }
        toLoginScreenButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toCatalogScreenButton.snp.top).offset(-UIConstants.contentInset + 4)
        }
        toSignupScreenButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toLoginScreenButton.snp.top).offset(-UIConstants.contentInset + 4)
        }
    }
}
