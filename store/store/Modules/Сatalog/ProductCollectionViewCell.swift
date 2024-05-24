//
//  ProductCollectionViewCell.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

protocol ProductCellDelegate {
    func didTapToAddProductToCart(cell: ProductCollectionViewCell)
}

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Private UI properties
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return label
    }()
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
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
    private lazy var priceButton: BaseButtonWithIcon = {
        let button = BaseButtonWithIcon()
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private var isUserAdmin: Bool = false
    var delegate: ProductCellDelegate?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public function
    func configure(with product: ShortProduct, isUserAdmin: Bool) {
        self.isUserAdmin = isUserAdmin
        initialize()
        productLabel.text = product.name
        productImage.image = product.image
        let stringArray = Helper.getStringRating(rating: product.adminRating)
        fullRatingStarLabel.text = stringArray.first
        emptyRatingStarLabel.text = stringArray.last
        ratingLabel.text = String(product.adminRating)
        priceButton.setLabelText(text: String(product.price) + " " + product.priceText)
    }
    // MARK: - Private function
    @objc func priceButtonTapped() {
        delegate?.didTapToAddProductToCart(cell: self)
    }
    private func initialize() {
        let xStack = UIStackView()
        xStack.distribution = .fill
        xStack.axis = .horizontal
        xStack.spacing = 10
        xStack.addArrangedSubview(fullRatingStarLabel)
        xStack.addArrangedSubview(emptyRatingStarLabel)
        xStack.addArrangedSubview(ratingLabel)
        xStack.setCustomSpacing(6, after: emptyRatingStarLabel)
        xStack.setCustomSpacing(0, after: fullRatingStarLabel)
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .equalCentering
        yStack.alignment = .center
        yStack.spacing = 6
        addSubview(yStack)
        priceButton.isEnabled = true
        switch isUserAdmin {
        case false:
            [productImage, productLabel, xStack, priceButton].forEach({yStack.addArrangedSubview($0)})
            priceButton.addRightIcon(imageIcon: UIImage(named: "cartProductIcon") ?? UIImage())
            priceButton.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        case true:
            [productImage, productLabel, priceButton].forEach({yStack.addArrangedSubview($0)})
        }
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        priceButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(4)
            make.height.equalTo(30)
        }
    }
}
