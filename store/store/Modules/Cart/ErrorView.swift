//
//  EmpryCartView.swift
//  store
//
//  Created by Evelina on 05.07.2023.
//

import UIKit

class ErrorView: UIView {
    // MARK: - Private constants
    private enum UIConstants {
        static let imageHeightWidth: CGFloat = 200
        static let contentInset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 195
    }
    // MARK: - Private UI properties
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20) ?? UIFont()
        return label
    }()
    private lazy var viewImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var viewButton: BaseButton = {
        let button = BaseButton()
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public function
    func setText(text: String) {
        informationLabel.text = text
    }
    func setImage(image: UIImage) {
        viewImage.image = image
    }
    func setButtonTitle(title: String) {
        viewButton.setLabelText(text: title)
    }
    func getButton() -> UIButton {
        return viewButton
    }
    // MARK: - Private function
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
//        yStack.distribution = .fillProportionally
        yStack.alignment = .center
        yStack.spacing = 16
        yStack.addArrangedSubview(viewImage)
        yStack.addArrangedSubview(informationLabel)
        yStack.addArrangedSubview(viewButton)
        addSubview(yStack)
        viewImage.snp.makeConstraints { make in
            make.width.height.equalTo(UIConstants.imageHeightWidth)
        }
        viewButton.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.buttonHeight)
            make.width.equalTo(UIConstants.buttonWidth)
        }
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
