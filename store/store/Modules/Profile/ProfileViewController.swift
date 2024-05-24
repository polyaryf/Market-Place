//
//  ProfileViewController.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let topSpace: CGFloat = 100
        static let buttonHeightWidth: CGFloat = 35
    }
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 40)
        label.text = Text.Profile.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var changeInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Profile.edit, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return button
    }()
    private lazy var profileView: UserProfileView = {
        let view = UserProfileView(isAdminView: isAdminProfile)
        return view
    }()
    private lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Profile.balance
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 35)
        label.textColor = UIColor(named: "greenColor")
        return label
    }()
    private lazy var aboutAppTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Profile.aboutApp
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var aboutAppView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var settingsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settingsIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var appThemeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Profile.ColorTheme.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var homeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "homeIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var appThemeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var appRightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rightArrow")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var homeRightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rightArrow")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var topUpBalanceButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: UIConstants.buttonHeightWidth, height: UIConstants.buttonHeightWidth)
        button.backgroundColor = UIColor(named: "greenColor")
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.setImage(UIImage(named: "whitePlusIcon"), for: .normal)
        return button
    }()
    var isAdminProfile: Bool
    var presenter: ProfilePresenter
    init(isAdminProfile: Bool, presenter: ProfilePresenter) {
        self.isAdminProfile = isAdminProfile
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
//        changeDeliveryButton.addTarget(self, action: #selector(changeDeliveryButtonTapped), for: .touchUpInside)
        [balanceTitleLabel, balanceLabel, topUpBalanceButton].forEach({balanceView.addSubview($0)})
        [settingsImage, aboutAppTitleLabel, appRightImage].forEach({aboutAppView.addSubview($0)})
        [homeImage, appThemeTitleLabel, homeRightImage].forEach({appThemeView.addSubview($0)})
        [infoLabel, profileView, changeInfoButton, balanceView, aboutAppView, appThemeView].forEach({view.addSubview($0)})
        switch isAdminProfile {
        case true: profileView.configureAdminView(with: presenter.admin)
            balanceLabel.text = BalanceConverter.convert(balance: presenter.admin.balance)
            topUpBalanceButton.isHidden = true
        case false: profileView.configureUserView(with: presenter.user)
            balanceLabel.text =  BalanceConverter.convert(balance: presenter.user.balance)
        }
        setupConstraints()
    }
    private func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.leading.equalToSuperview().inset(1.5 * UIConstants.contentInset)
        }
        profileView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(4 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.height.equalTo(110)
        }
        changeInfoButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileView.snp.top).offset(-4)
            make.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
        }
        balanceView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.height.equalTo(100)
        }
        balanceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        topUpBalanceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.width.height.equalTo(UIConstants.buttonHeightWidth)
        }
        aboutAppView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.height.equalTo(50)
        }
        settingsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.height.width.equalTo(20)
        }
        aboutAppTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(settingsImage.snp.trailing).offset(UIConstants.contentInset)
        }
        appRightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.width.height.equalTo(25)
        }
        appThemeView.snp.makeConstraints { make in
            make.top.equalTo(aboutAppView.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.height.equalTo(50)
        }
        homeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.height.width.equalTo(20)
        }
        appThemeTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(homeImage.snp.trailing).offset(UIConstants.contentInset)
        }
        homeRightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.width.height.equalTo(25)
        }
    }
}
