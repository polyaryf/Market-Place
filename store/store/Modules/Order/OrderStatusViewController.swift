//
//  OrderStatusViewController.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

protocol OrderStatusViewOutput {
    func viewDidTapToOrderHistoryScreen()
}

class OrderStatusViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let topSpace: CGFloat = 110
    }
    var presenter: OrderPresenter
    init(presenter: OrderPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-Bold", size: 25)
        label.text = Text.Order.OrderDone.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
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
    private lazy var nextButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Order.OrderDone.next)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // MARK: - Private functions
    private func configure() {
        addressLabel.text = presenter.order.address
        dateLabel.text = presenter.order.date
        paymentLabel.text = presenter.order.payment
    }
    @objc func nextButtonTapped() {
        presenter.viewDidTapToOrderHistoryScreen()
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        [statusLabel, deliveryLabel, addressLabel, dateTitleLabel,
         dateLabel, paymentTitleLabel, paymentLabel, nextButton].forEach({view.addSubview($0)})
        configure()
        setupConstraints()
    }
    private func setupConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
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
    }
}
