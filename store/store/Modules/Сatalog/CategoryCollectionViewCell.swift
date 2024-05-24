//
//  CategoryCollectionViewCell.swift
//  store
//
//  Created by Evelina on 03.07.2023.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Private UI properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return label
    }()
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
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
    func configure(with category: Category) {
        titleLabel.text = category.title
        categoryImage.image = category.image
    }
    // MARK: - Private function
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .fill
        yStack.alignment = .leading
        addSubview(yStack)
        yStack.addArrangedSubview(categoryImage)
        yStack.addArrangedSubview(titleLabel)
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
