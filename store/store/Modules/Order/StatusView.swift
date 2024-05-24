//
//  StatusView.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

class StatusView: UIView {
    // MARK: - Private UI properties
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 13)
        label.textColor = .white
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
    // MARK: - Public functions
    func configure(with status: OrderStatusEnum) {
        statusLabel.text = status.rawValue
        switch status {
        case .delivery: backgroundColor = UIColor(named: "purpleColor")
        case .assembly: backgroundColor = UIColor(named: "blueColor")
        case .new: backgroundColor = UIColor(named: "greenColor")
        case .canceled: backgroundColor = UIColor(named: "redColor")
        case .done: backgroundColor = UIColor(named: "baseButtonColor")
        }
        frame.size = CGSize(width: (statusLabel.text?.count ?? 1) * 10 + 20, height: 30)
    }
    // MARK: - Private functions
    private func initialize() {
        layer.cornerRadius = 15
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
