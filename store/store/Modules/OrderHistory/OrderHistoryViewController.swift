//
//  OrderHistoryViewController.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

protocol OrderHistoryViewOutput {
    func viewDidTapToOpenOrder(with index: Int)
}

class OrderHistoryViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let topSpace: CGFloat = 80
        static let viewCornerRadius: CGFloat = 15
        static let contentInset: CGFloat = 16
        static let errorViewWidth: CGFloat = 300
        static let errorViewHeight: CGFloat = 310
    }
    var presenter: OrderHistoryPresenter
    init(presenter: OrderHistoryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var orderTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.OrderHistory.orders
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var orderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: OrderCollectionViewCell.self))
        [orderCollectionView, orderTitleLabel].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        orderTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        orderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(orderTitleLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.bottom.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
extension OrderHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.orders.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: OrderCollectionViewCell.self),
            for: indexPath) as? OrderCollectionViewCell else { return OrderCollectionViewCell()}
        cell.configure(with: presenter.orders[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.viewDidTapToOpenOrder(with: indexPath.row)
    }
}
extension OrderHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 20
        let itemHeight = 260
        let itemWidth = collectionViewWidth
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3 // Set the desired spacing between columns
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // Set the desired spacing between rows
    }
}

