//
//  UserProfileView.swift
//  store
//
//  Created by Evelina on 06.07.2023.
//

import UIKit

class UserProfileView: UIView {
    // MARK: - Private UI properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return label
    }()
    private lazy var fullRatingStarLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "yellowColor")
        return label
    }()
    private lazy var emptyRatingStarLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "emptyStarColor")
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var reviewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "baseButtonColor")
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "baseButtonColor")
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "baseButtonColor")
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    // MARK: - Public functions
    func configureAdminView(with admin: Admin) {
        let stringArray = Helper.getStringRating(rating: admin.rating)
        fullRatingStarLabel.text = stringArray.first
        emptyRatingStarLabel.text = stringArray.last
        ratingLabel.text = String(admin.rating)
        nameLabel.text = admin.name
        reviewsLabel.text = "(\(admin.reviews))"
        phoneNumberLabel.text = admin.phoneNumber
    }
    func configureUserView(with user: User) {
        nameLabel.text = user.name + " " + user.surname
        phoneNumberLabel.text = user.phoneNumber
        emailLabel.text = user.email
    }
    var isAdminView: Bool
    // MARK: - Init
    init(isAdminView: Bool) {
        self.isAdminView = isAdminView
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 15
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    private func initialize() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(named: "titleTextColor")
        let xStack = UIStackView()
        xStack.distribution = .fill
        xStack.axis = .horizontal
        xStack.spacing = 6
        [fullRatingStarLabel, emptyRatingStarLabel, ratingLabel, reviewsLabel].forEach({xStack.addArrangedSubview($0)})
        xStack.setCustomSpacing(0, after: fullRatingStarLabel)
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .leading
        yStack.spacing = 7
        switch isAdminView {
        case true: [nameLabel, xStack, lineView, phoneNumberLabel].forEach({yStack.addArrangedSubview($0)})
            lineView.snp.makeConstraints { make in
            make.width.equalTo(xStack.snp.width)
            make.height.equalTo(0.4)
            }
        case false: [nameLabel, emailLabel, lineView, phoneNumberLabel].forEach({yStack.addArrangedSubview($0)})
            lineView.snp.makeConstraints { make in
                make.width.equalTo(emailLabel.snp.width)
                make.height.equalTo(0.4)
            }
        }
        lineView.alpha = 0.5
        addSubview(yStack)
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
