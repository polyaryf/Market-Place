//
//  MakingOrderViewController.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

protocol MakingOrderViewOutput {
    func viewDidTapToMakeOrder(payment: String)
    func viewDidTapToChangeDelivery()
    func viewDidTapToReviewOrder()
}

enum MakingOrderScreenStateEnum {
    case makingOrder
    case makeReturn
    case changeOrderStatus
    case viewOrder
}

class MakingOrderViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let topSpace: CGFloat = 80
    }
    var screenState: MakingOrderScreenStateEnum
    var presenter: OrderPresenter
    init(screenState: MakingOrderScreenStateEnum, presenter: OrderPresenter) {
        self.screenState = screenState
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var makingOrderTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Order.MakingOrder.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Order.MakingOrder.order
        label.textColor = UIColor(named: "titleTextColor")
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
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Order.MakingOrder.address
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 13)
        label.text = Text.Order.MakingOrder.address
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Order.MakingOrder.deliveryDate
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 13)
        label.text = Text.Order.MakingOrder.address
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var paymentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Order.MakingOrder.Payment.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var paymentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 13)
        label.text = Text.Order.MakingOrder.Payment.card
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var changeDeliveryButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.change, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-Regular", size: 16) ?? UIFont()
        return button
    }()
    private lazy var changePaymentButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.change, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-Regular", size: 16) ?? UIFont()
        return button
    }()
    private lazy var changeDateButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.change, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-Regular", size: 16) ?? UIFont()
        return button
    }()
    private lazy var nextButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Cart.order)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var reviewButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: "Оценить заказ")
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var statusContainerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var statusView: StatusView = {
        let view = StatusView()
        return view
    }()
    private lazy var changeStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.change, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-Regular", size: 16) ?? UIFont()
        return button
    }()
    private lazy var statusTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 20)
        label.text = Text.Admin.EditOrder.status
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .white
        return view
    }()
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: "", message: Text.Order.MakingOrder.Payment.title, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: Text.Order.MakingOrder.Payment.card, style: .default, handler: { _ in
            self.paymentLabel.text = Text.Order.MakingOrder.Payment.card
        }))
        actionSheet.addAction(UIAlertAction(title: Text.Order.MakingOrder.Payment.cash, style: .default, handler: { _ in
            self.paymentLabel.text = Text.Order.MakingOrder.Payment.cash
        }))
        actionSheet.addAction(UIAlertAction(title: Text.cancel, style: .cancel))
        present(actionSheet, animated: true)
    }
    private func showAlert() {
        let alert = UIAlertController(title: Text.Order.Return.Confirm.title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Text.Order.Return.Confirm.yes, style: .default, handler: { _ in
            // оформление возрата
            self.startLoading()
        }))
        alert.addAction(UIAlertAction(title: Text.Order.Return.Confirm.no, style: .cancel))
        present(alert, animated: true)
    }
    private func configure(amount: Int) {
        productsLabel.text = Text.Order.MakingOrder.order + " / \(images.count) " + Text.Order.MakingOrder.amount
        addressLabel.text = presenter.order.address
        dateLabel.text = presenter.order.deliveryDate
        switch presenter.order.status {
        case .delivery, .new, .assembly: dateTitleLabel.text = Text.OrderHistory.orderDateExpected
        case .done, .canceled:  dateTitleLabel.text = Text.OrderHistory.orderDateDone
        }
    }
    private var images: [Data?] = [UIImage(named: "exampleProductImage")?.pngData(), UIImage(named: "exampleProductImage")?.pngData()]
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // MARK: - Private methods
    @objc func changePaymentButtonTapped() {
        showActionSheet()
    }
    @objc func changeDeliveryButtonTapped() {
        presenter.viewDidTapToChangeDelivery()
    }
    @objc func makeOrderButtonTapped() {
        startLoading()
        presenter.viewDidTapToMakeOrder(payment: paymentLabel.text  ?? "")
    }
    @objc func makeReturnButtonTapped() {
        showAlert()
    }
    @objc func reviewButtonTapped() {
        presenter.viewDidTapToReviewOrder()
    }
    private func startLoading() {
        nextButton.setLabelText(text: "")
        nextButton.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(15)
        }
        loadingView.startAnimating()
    }
    // MARK: - State of screen
    private func makeReturnState() {
        reviewButton.isHidden = false
        makingOrderTitleLabel.isHidden = true
        changeDeliveryButton.isHidden = true
        changePaymentButton.isHidden = true
        nextButton.setLabelText(text: Text.Order.Return.button)
        nextButton.addTarget(self, action: #selector(makeReturnButtonTapped), for: .touchUpInside)
        nextButton.backgroundColor = UIColor(named: "baseButtonColor")
    }
    private func changeOrderStatusState() {
        productsLabel.text = Text.Admin.EditOrder.order + " \(presenter.order.number)"
        + " / \(images.count) " + Text.Order.MakingOrder.amount
        makingOrderTitleLabel.isHidden = true
        changePaymentButton.isHidden = true
        changeDeliveryButton.isHidden = true
        nextButton.setLabelText(text: Text.Admin.EditOrder.save)
        nextButton.addTarget(self, action: #selector(makeReturnButtonTapped), for: .touchUpInside)
        [statusTitleLabel, changeStatusButton, statusView].forEach({statusContainerView.addSubview($0)})
        statusView.configure(with: presenter.order.status)
        [statusContainerView, changeDateButton].forEach({view.addSubview($0)})
        changeDateButton.snp.makeConstraints { make in
            make.bottom.equalTo(dateTitleLabel.snp.top).offset(6)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        statusContainerView.snp.makeConstraints { make in
            make.top.equalTo(paymentLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        statusTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        changeStatusButton.snp.makeConstraints { make in
            make.centerY.equalTo(statusTitleLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
        statusView.snp.makeConstraints { make in
            make.top.equalTo(statusTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.width.equalTo(statusView.frame.size.width)
            make.height.equalTo(statusView.frame.size.height)
        }
    }
    private func viewOrderState() {
        makingOrderTitleLabel.isHidden = true
        changeDeliveryButton.isHidden = true
        changePaymentButton.isHidden = true
        nextButton.isHidden = true
    }
    private func makingOrderState() {
        nextButton.setLabelText(text: Text.Cart.order)
        nextButton.addTarget(self, action: #selector(makeOrderButtonTapped), for: .touchUpInside)
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        changePaymentButton.addTarget(self, action: #selector(changePaymentButtonTapped), for: .touchUpInside)
        changeDeliveryButton.addTarget(self, action: #selector(changeDeliveryButtonTapped), for: .touchUpInside)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        [makingOrderTitleLabel, productsLabel, imageCollectionView, deliveryLabel,
         addressLabel, changeDeliveryButton, dateTitleLabel, dateLabel, paymentTitleLabel,
         paymentLabel, changePaymentButton, nextButton, reviewButton].forEach({view.addSubview($0)})
        configure(amount: presenter.productImages.count)
        setupConstraints()
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        reviewButton.isHidden = true
        switch screenState {
        case .makeReturn: makeReturnState()
        case .makingOrder: makingOrderState()
        case .changeOrderStatus:
            changeOrderStatusState()
        case .viewOrder:
            viewOrderState()
        }
        
    }
    private func setupConstraints() {
        makingOrderTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        productsLabel.snp.makeConstraints { make in
            make.top.equalTo(makingOrderTitleLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(productsLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        changeDeliveryButton.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        dateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        paymentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        changePaymentButton.snp.makeConstraints { make in
            make.centerY.equalTo(paymentTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        paymentLabel.snp.makeConstraints { make in
            make.top.equalTo(paymentTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(4 * UIConstants.contentInset)
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
        reviewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-UIConstants.contentInset)
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
    }
}

extension MakingOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
extension MakingOrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemHeight = 80
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
