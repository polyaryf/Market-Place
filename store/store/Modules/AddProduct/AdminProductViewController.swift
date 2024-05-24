//
//  AdminProductViewController.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import UIKit

protocol AdminProductViewOutput {
    func viewDidTapToAddProduct()
}

class AdminProductViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let topSpace: CGFloat = 80
        static let viewCornerRadius: CGFloat = 15
        static let contentInset: CGFloat = 16
        static let errorViewWidth: CGFloat = 300
        static let errorViewHeight: CGFloat = 310
    }
    // MARK: - Private UI properties
    private lazy var myProductsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Admin.myProducts
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private lazy var addProductButton: BaseButtonWithIcon = {
        let button = BaseButtonWithIcon()
        button.setLabelText(text: Text.Admin.CreateProduct.button)
        button.addLeftIcon(imageIcon: UIImage(named: "addImageIcon") ?? UIImage())
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    var presenter: AdminPresenter
    init(presenter: AdminPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCollectionViewCell.self,
                                       forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self))
        [myProductsLabel, productCollectionView, addProductButton].forEach({view.addSubview($0)})
        view.bringSubviewToFront(addProductButton)
        addProductButton.addTarget(self, action: #selector(addProductButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    @objc func addProductButtonTapped() {
        presenter.viewDidTapToAddProduct()
    }
    private func setupConstraints() {
        myProductsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myProductsLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalToSuperview().offset(UIConstants.contentInset)
        }
        addProductButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(7 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
extension AdminProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 25
        let itemHeight = 220
        let itemWidth = collectionViewWidth / 2
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
        return 16 // Set the desired spacing between rows
    }
}
extension AdminProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductCollectionViewCell.self),
            for: indexPath) as? ProductCollectionViewCell else { return ProductCollectionViewCell()}
        cell.configure(with: presenter.products[indexPath.row], isUserAdmin: true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // открытие товара
    }
}

