//
//  BaseButtonWithIcon.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

class BaseButtonWithIcon: BaseButton {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let iconWidthHeight: CGFloat = 26
        static let buttonCornerRadius: CGFloat = 15
    }
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        return image
    }()
    func addRightIcon(imageIcon: UIImage) {
        addSubview(iconImageView)
        iconImageView.image = imageIcon
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.width.height.equalTo(UIConstants.iconWidthHeight)
        }
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
    func addLeftIcon(imageIcon: UIImage) {
        addSubview(iconImageView)
        iconImageView.image = imageIcon
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.width.height.equalTo(UIConstants.iconWidthHeight)
        }
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
