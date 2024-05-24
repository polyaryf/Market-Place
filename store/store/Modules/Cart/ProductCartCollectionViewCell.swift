//
//  ProductCartCollectionViewCell.swift
//  store
//
//  Created by Evelina on 05.07.2023.
//

import UIKit

protocol ProductCartCellDelegate {
    func deleteCell(cell: ProductCartCollectionViewCell)
    func increaseAmount(cell: ProductCartCollectionViewCell)
    func reduceAmount(cell: ProductCartCollectionViewCell)
}

class ProductCartCollectionViewCell: UICollectionViewCell {
    // MARK: - Private constants
    private enum UIConstants {
        static let priceLabelCornerRadius: CGFloat = 20
        static let contentInset: CGFloat = 16
    }
    var delegate: ProductCartCellDelegate?
    // MARK: - Private UI properties
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "minusIcon"), for: .normal)
        return button
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        return button
    }()
    private lazy var priceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(named: "greenColor")
        return view
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 18) ?? UIFont()
        label.textColor = .white
        return label
    }()
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        label.textColor = UIColor(named: "purpleColor")
        return label
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
    func configure(with product: Product) {
        productLabel.text = product.name
        productImage.image = UIImage(data: product.image ?? Data())
        priceLabel.text = "\(product.price) " + "бонусов"
        amountLabel.text = String(product.amount)
        priceView.snp.makeConstraints { make in
            make.width.equalTo(countNumbers(number: Int(product.price)) * 10 + 7 * 10 + 35)
        }
    }
    func addBottomLine() {
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.size.height - 0.4,
                                            width: self.frame.size.width, height: 0.4))
        lineView.backgroundColor = UIColor(named: "titleTextColor")
        lineView.alpha = 0.3
        self.addSubview(lineView)
    }
    // MARK: - Private function
    private func countNumbers(number: Int) -> Int {
       var count = 0
       var number = number
       if number == 0 {return 1}
       while number > 0 {
           number /= 10
          count += 1
       }
       return count
    }
    @objc func minusButtonTapped() {
        guard let amount: Int = Int(amountLabel.text ?? "1") else {return}
        if amount == 1 {
            if delegate != nil {
                delegate?.deleteCell(cell: self)
            }
        } else {
            delegate?.reduceAmount(cell: self)
            amountLabel.text = String(amount - 1)
        }
    }
    @objc func plusButtonTapped() {
        guard let amount: Int = Int(amountLabel.text ?? "1") else {return}
        amountLabel.text = String(amount + 1)
        delegate?.increaseAmount(cell: self)
    }
    private func initialize() {
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        let xStack = UIStackView()
        xStack.distribution = .fill
        xStack.axis = .horizontal
        xStack.spacing = 8
        xStack.addArrangedSubview(minusButton)
        xStack.addArrangedSubview(amountLabel)
        xStack.addArrangedSubview(plusButton)
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .fill
        yStack.alignment = .leading
        yStack.spacing = UIConstants.contentInset
        yStack.addArrangedSubview(productLabel)
        priceView.addSubview(priceLabel)
        yStack.addArrangedSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        addSubview(xStack)
        addSubview(yStack)
        addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(110)
        }
        priceLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        yStack.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.top).inset(UIConstants.contentInset)
            make.trailing.equalToSuperview()
            make.leading.equalTo(productImage.snp.trailing).offset(UIConstants.contentInset)
        }
        xStack.snp.makeConstraints { make in
            make.top.equalTo(yStack.snp.bottom).offset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
    }
}
