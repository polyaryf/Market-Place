//
//  BaseButton.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class BaseButton: UIButton {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let iconWidthHeight: CGFloat = 25
        static let buttonCornerRadius: CGFloat = 15
    }
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = UIConstants.buttonCornerRadius
        addLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addLabel() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    func setLabelText(text: String) {
        textLabel.text = text
    }
}
