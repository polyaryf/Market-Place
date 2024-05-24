//
//  ProductViewController.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class ProductViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let textFieldWidth: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
    }
    var presenter: ProductPresenter
    init(presenter: ProductPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private lazy var searchTextField: UITextField = {
        let textField = TextFieldWithIcon()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Catalog.search
        textField.backgroundColor = UIColor(named: "backgroundColor")
        textField.setImagetoLeft(image: UIImage(named: "searchIcon") ?? UIImage(),
                                 pointX: -22, pointY: -10, width: 85, height: 85)
        return textField
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
        return button
    }()
    private lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(named: "greenColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 25) ?? UIFont()
        return label
    }()
    private lazy var adminView: UserProfileView = {
        let view = UserProfileView(isAdminView: true)
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    private lazy var addToCartButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Products.addToCart)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var addedToCartButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Products.addedToCart)
        button.backgroundColor = UIColor(named: "purpleColor")
        return button
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
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        label.textColor = UIColor(named: "purpleColor")
        label.text = "1"
        return label
    }()
    private lazy var amountView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "baseButtonColor")
        label.text = Text.Products.description
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    private lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-Regular", size: 14) ?? UIFont()
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 50)
        return scrollView
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func configure(with product: ExpandedProduct) {
        productLabel.text = product.name
        priceLabel.text = product.price
        adminView.configureAdminView(with: product.admin)
        productDescriptionLabel.text = product.description
    }
    @objc func addToCartButtonTapped() {
        showAddedToCart()
    }
    @objc func addedToCartButtonTapped() {
        hideAddedToCart()
    }
    @objc func minusButtonTapped() {
        guard let amount: Int = Int(amountLabel.text ?? "1") else {return}
        if amount != 1 {
            amountLabel.text = String(amount - 1)
        }
    }
    @objc func plusButtonTapped() {
        guard let amount: Int = Int(amountLabel.text ?? "1") else {return}
        amountLabel.text = String(amount + 1)
    }
    // MARK: - Private functions
    private func showAddedToCart() {
        addToCartButton.isHidden = true
        addedToCartButton.isHidden = false
        amountView.isHidden = false
    }
    private func hideAddedToCart() {
        addToCartButton.isHidden = false
        addedToCartButton.isHidden = true
        amountView.isHidden = true
    }
    private func setupView() {
        view.backgroundColor = .white
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        addedToCartButton.addTarget(self, action: #selector(addedToCartButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        [minusButton, amountLabel, plusButton].forEach({amountView.addSubview($0)})
        [filterButton, searchTextField, scrollView, amountView, addToCartButton, addedToCartButton].forEach({view.addSubview($0)})
        [productLabel, priceLabel].forEach({titleContainerView.addSubview($0)})
        [descriptionTitleLabel, productDescriptionLabel].forEach({descriptionView.addSubview($0)})
        [imageCollectionView, titleContainerView, adminView, descriptionView].forEach({scrollView.addSubview($0)})
        configure(with: presenter.product)
        setupConstraints()
        hideAddedToCart()
        view.bringSubviewToFront(addToCartButton)
        view.bringSubviewToFront(addedToCartButton)
        view.bringSubviewToFront(amountView)
    }
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.leading.equalToSuperview().inset(2.5 * UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 4)
            make.width.height.equalTo(25)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        imageCollectionView.snp.makeConstraints { make in
            make.height.equalTo(320)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(120)
        }
        productLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        adminView.snp.makeConstraints { make in
            make.top.equalTo(titleContainerView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(110)
        }
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(adminView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(200)
        }
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
        }
        addedToCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
        }
        amountView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.trailing.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
        }
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
        }
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        amountLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.product.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self),
            for: indexPath) as? ProductImageCollectionViewCell else { return ProductImageCollectionViewCell()}
        cell.configure(with: presenter.product.images[indexPath.row]?.pngData() ?? Data())
        return cell
    }
}
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemHeight = 300
        let itemWidth = collectionViewWidth
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
