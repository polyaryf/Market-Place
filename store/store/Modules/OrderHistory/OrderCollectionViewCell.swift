//
//  OrderCollectionViewCell.swift
//  store
//
//  Created by Evelina on 06.07.2023.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let collectionViewHeight: CGFloat = 80
    }
    // MARK: - Private UI properties
    private lazy var orderDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.textColor = UIColor(named: "titleTextColor")
        label.text = Text.OrderHistory.orderFrom
        return label
    }()
    private lazy var orderNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 14)
        label.textColor = UIColor(named: "greenColor")
        return label
    }()
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var statusView: StatusView = {
        let view = StatusView()
        return view
    }()
    private lazy var deliveryDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "baseButtonColor")
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private var images: [Data?] = []
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public functions
    func configure(with order: Order) {
        orderDateLabel.text = Text.OrderHistory.orderFrom + " \(order.date)"
        orderNumberLabel.text = order.number
        deliveryLabel.text = order.delivery.rawValue
        statusView.configure(with: order.status)
        switch order.status {
        case .delivery, .new, .assembly: deliveryDateLabel.text = Text.OrderHistory.orderDateExpected + " \(order.deliveryDate)"
        case .done, .canceled:  deliveryDateLabel.text = Text.OrderHistory.orderDateDone + " \(order.deliveryDate)"
        }
        images = order.products.map({$0.image})
    }
    // MARK: - Private functions
    private func initialize() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(named: "titleTextColor")
        lineView.alpha = 0.5
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .fill
        yStack.alignment = .leading
        yStack.spacing = 8
        addSubview(yStack)
        [orderDateLabel, orderNumberLabel, lineView, deliveryLabel, statusView,
         deliveryDateLabel, imageCollectionView].forEach({yStack.addArrangedSubview($0)})
        imageCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIConstants.collectionViewHeight)
        }
        statusView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
        lineView.snp.makeConstraints { make in
            make.width.equalTo(yStack.snp.width)
            make.height.equalTo(0.4)
        }
    }
}
extension OrderCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self),
            for: indexPath) as? ProductImageCollectionViewCell else { return ProductImageCollectionViewCell()}
        cell.configure(with: images[indexPath.row] ?? Data())
        return cell
    }
}
extension OrderCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemHeight = 75
        let itemWidth = collectionViewWidth / 4
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6 // Set the desired spacing between columns
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6 // Set the desired spacing between rows
    }
}
