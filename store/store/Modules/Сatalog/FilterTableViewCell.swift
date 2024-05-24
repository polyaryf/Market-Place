//
//  FilterTableViewCell.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let checkBoxWidthHeight: CGFloat = 30
    }
    // MARK: - Private UI properties
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleTextColor")
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16) ?? UIFont()
        return label
    }()
    private lazy var checkBox: FilterCheckBox = {
        let checkBox = FilterCheckBox(frame: CGRect(x: 0, y: 0,
                                                    width: UIConstants.checkBoxWidthHeight,
                                                    height: UIConstants.checkBoxWidthHeight))
        return checkBox
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public functions
    func configure(with category: String) {
        categoryLabel.text = category
    }
    func checkBoxTapped() {
        if checkBox.isCheck {
            checkBox.uncheck()
        } else {
            checkBox.check()
        }
    }
    // MARK: - Private functions
    private func initialize() {
        addSubview(categoryLabel)
        addSubview(checkBox)
        backgroundColor = .clear
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        checkBox.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 10)
            make.centerY.equalToSuperview()
            make.width.equalTo(UIConstants.checkBoxWidthHeight)
            make.height.equalTo(UIConstants.checkBoxWidthHeight)
        }
    }
}
