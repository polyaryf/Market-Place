//
//  ProductImageCollectionViewCell.swift
//  store
//
//  Created by Evelina on 07.07.2023.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Private UI properties
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
//        layer.borderColor = UIColor.red.cgColor
//        layer.borderWidth = 3.0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    private func setupView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    // MARK: - Public functions
    func configure(with image: Data) {
        imageView.image = UIImage(data: image)
        imageView.contentMode = .scaleToFill
    }
}
