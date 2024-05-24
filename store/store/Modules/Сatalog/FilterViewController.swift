//
//  FilterViewController.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class FilterViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let textFieldCornerRadius: CGFloat = 20
        static let topSpace: CGFloat = 75
        static let contentInset: CGFloat = 16
        static let textFieldHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 18
    }
    private let categoriesNames: [String] = [Text.Filter.allCategories,
                                             Text.Catalog.Categories.clothes,
                                             Text.Catalog.Categories.home,
                                             Text.Catalog.Categories.beauty,
                                             Text.Catalog.Categories.accessories,
                                             Text.Catalog.Categories.electronics,
                                             Text.Catalog.Categories.children,
                                             Text.Catalog.Categories.animals,
                                             Text.Catalog.Categories.sport]
    private var choosenCategory: Int = 0
    // MARK: - Private UI properties
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 18)
        label.text = Text.Filter.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Filter.cancel, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Montserrat", size: 18) ?? UIFont()
        return button
    }()
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        label.text = Text.Filter.price
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var fromPriceTextField: UITextField = {
        let textField = PriceTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.backgroundColor = .white
        textField.addLeftText(text: Text.Filter.Price.from, pointX: 12, pointY: 10, width: 25, height: 20)
        return textField
    }()
    private lazy var toPriceTextField: UITextField = {
        let textField = PriceTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.backgroundColor = .white
        textField.addLeftText(text: Text.Filter.Price.to, pointX: 12, pointY: 10, width: 25, height: 20)
        return textField
    }()
    private lazy var applyFilterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(Text.Filter.apply, for: .normal)
        button.backgroundColor = UIColor(named: "greenColor")
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 4 * UIConstants.contentInset,
                                                bottom: 12, right: 4 * UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 20) ?? UIFont()
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        fromPriceTextField.delegate = self
        toPriceTextField.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: String(describing: FilterTableViewCell.self))
        view.addSubview(filterLabel)
        view.addSubview(categoryTableView)
        view.addSubview(priceLabel)
        view.addSubview(cancelButton)
        view.addSubview(applyFilterButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    @objc func cancelButtonTapped() {
        
    }
    private func setupConstraints() {
        filterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(filterLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 5)
        }
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(filterLabel.snp.bottom).offset(UIConstants.contentInset + 5)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(430)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTableView.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset + 5)
        }
        let xStack = UIStackView()
        xStack.distribution = .fillEqually
        xStack.axis = .horizontal
        xStack.spacing = 16
        xStack.addArrangedSubview(fromPriceTextField)
        xStack.addArrangedSubview(toPriceTextField)
        view.addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        applyFilterButton.snp.makeConstraints { make in
            make.top.equalTo(xStack.snp.bottom).offset(5 * UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset + 15)
        }
    }
}
extension FilterViewController: UITextFieldDelegate {
    
}
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self), for: indexPath) as? FilterTableViewCell else {return FilterTableViewCell()}
        if indexPath.row == choosenCategory {
            cell.checkBoxTapped()
        }
        let colorView = UIView()
        colorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = colorView
        cell.configure(with: categoriesNames[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self), for: indexPath)
                as? FilterTableViewCell else {return}
        cell.checkBoxTapped()
        guard let uncheckedCell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self), for: IndexPath(row: choosenCategory, section: 0))
                as? FilterTableViewCell else {return}
        uncheckedCell.checkBoxTapped()
        let oldCategory = choosenCategory
        choosenCategory = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadRows(at: [indexPath, IndexPath(row: oldCategory, section: 0)], with: .none)
    }
}
