//
//  CartViewController.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

protocol CartViewOutput {
    func viewDidTapToMakeOrder()
    func viewDidTapToChangeAmount(with index: Int)
    func viewDidTapToDeleteProduct(with indexPath: IndexPath)
    func viewDidTapToDeleteAllProducts()
    func viewDidTapToUpdateCart()
}

class CartViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let topSpace: CGFloat = 80
        static let viewCornerRadius: CGFloat = 15
        static let contentInset: CGFloat = 16
        static let errorViewWidth: CGFloat = 300
        static let errorViewHeight: CGFloat = 310
    }
    private var previousContentOffset: CGFloat = 0
    var presenter: CartPresenter
    init(presenter: CartPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Cart.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 25)
        label.text = Text.Cart.products
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "trashIcon"), for: .normal)
        return button
    }()
    private lazy var makeOrderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        return view
    }()
    private lazy var makeOrderButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Cart.order)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.Cart.price
        label.textColor = UIColor(named: "baseButtonColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 14) ?? UIFont()
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 23) ?? UIFont()
        return label
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.setImage(image: UIImage(named: "emptyCartImage") ?? UIImage())
        view.setButtonTitle(title: Text.Cart.toCatalog)
        view.setText(text: Text.Cart.empty)
        return view
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setProductsLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidTapToUpdateCart()
        calculateFinalPrice()
        setProductsLabel()
        if presenter.products.isEmpty {
            showErrorView()
        }
    }
    // MARK: - Public methods
    func updateCollectionView() {
        productsCollectionView.reloadData()
        if presenter.products.isEmpty {
            showErrorView()
        } else {
            calculateFinalPrice()
            setProductsLabel()
            errorView.isHidden = true
            containerView.isHidden = false
        }
    }
    func deleteCollectionViewCell(indexPath: IndexPath) {
        productsCollectionView.deleteItems(at: [indexPath])
        setProductsLabel()
        calculateFinalPrice()
    }
    // MARK: - Private methods
    private func calculateFinalPrice() {
        var finalPrice = 0
        presenter.products.forEach({finalPrice+=Int($0.price * $0.amount)})
        priceLabel.text = "\(finalPrice) " + "бонуса"
    }
    private func setProductsLabel() {
        productsLabel.text = Text.Cart.products + " (" + "\(presenter.products.count))"
    }
    private func setFinalPriceLabel() {
        priceLabel.text = Text.Cart.products + " (" + "\(presenter.products.count))"
    }
    private func showActionSheet(description: String, deleteButtonText: String, action: ((UIAlertAction) -> Void)?) {
        let actionSheet = UIAlertController(title: "", message: description, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: deleteButtonText, style: .destructive, handler: action))
        actionSheet.addAction(UIAlertAction(title: Text.cancel, style: .cancel))
        present(actionSheet, animated: true)
    }
    private func showErrorView() {
        errorView.isHidden = false
        containerView.isHidden = true
    }
    private func setupOrderView() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .equalCentering
        yStack.alignment = .leading
        yStack.spacing = 6
        yStack.addArrangedSubview(priceTitleLabel)
        yStack.addArrangedSubview(priceLabel)
        let xStack = UIStackView()
        xStack.alignment = .top
        xStack.axis = .horizontal
        xStack.spacing = 10
        xStack.addArrangedSubview(yStack)
        makeOrderButton.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(35)
        }
        xStack.addArrangedSubview(makeOrderButton)
        makeOrderView.addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
    @objc func deleteAllButtonTapped() {
        showActionSheet(description: Text.Cart.deleteAll, deleteButtonText: Text.Cart.deleteAllButton, action: { _ in
            self.presenter.products.removeAll()
            self.showErrorView()
        })
        presenter.viewDidTapToDeleteAllProducts()
    }
    @objc func makeOrderButtonTapped() {
        presenter.viewDidTapToMakeOrder()
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        makeOrderButton.addTarget(self, action: #selector(makeOrderButtonTapped), for: .touchUpInside)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductCartCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductCartCollectionViewCell.self))
        view.addSubview(cartLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(containerView)
        containerView.addSubview(productsLabel)
        containerView.addSubview(productsCollectionView)
        view.addSubview(errorView)
        errorView.isHidden = true
        setupOrderView()
        containerView.addSubview(makeOrderView)
        setupConstraints()
        calculateFinalPrice()
    }
    private func setupConstraints() {
        cartLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(cartLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 4)
            make.width.height.equalTo(33)
        }
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(cartLabel.snp.bottom)
        }
        errorView.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.errorViewHeight)
            make.width.equalTo(UIConstants.errorViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(cartLabel.snp.bottom).offset(2 * UIConstants.contentInset)
        }
        productsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(productsLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalTo(makeOrderView.snp.top).offset(UIConstants.contentInset)
        }
        makeOrderView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductCartCollectionViewCell.self),
            for: indexPath) as? ProductCartCollectionViewCell else { return ProductCartCollectionViewCell()}
        cell.configure(with: presenter.products[indexPath.row])
        if indexPath.row != presenter.products.count - 1 {
            cell.addBottomLine()
        }
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // открытие товара
    }
}
extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 25
        let itemHeight = 150
        let itemWidth = collectionViewWidth
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension CartViewController: ProductCartCellDelegate {
    func deleteCell(cell: ProductCartCollectionViewCell) {
        guard let indexPath = productsCollectionView.indexPath(for: cell) else {return}
        showActionSheet(description: Text.Cart.deleteOne, deleteButtonText: Text.Cart.deleteOneButton, action: { _ in
            self.presenter.viewDidTapToDeleteProduct(with: indexPath)
            if self.presenter.products.count == 0 {
                self.showErrorView()
            }
        })
    }
    func increaseAmount(cell: ProductCartCollectionViewCell) {
        guard let indexPath = productsCollectionView.indexPath(for: cell) else {return}
        presenter.products[indexPath.row].amount+=1
        calculateFinalPrice()
        presenter.viewDidTapToChangeAmount(with: indexPath.row)
    }
    func reduceAmount(cell: ProductCartCollectionViewCell) {
        guard let indexPath = productsCollectionView.indexPath(for: cell) else {return}
        presenter.products[indexPath.row].amount-=1
        calculateFinalPrice()
        presenter.viewDidTapToChangeAmount(with: indexPath.row)
    }
}
