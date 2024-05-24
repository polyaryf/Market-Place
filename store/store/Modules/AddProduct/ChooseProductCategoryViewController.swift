//
//  ChooseProductCategoryViewController.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import UIKit

protocol ChooseProductCategoryViewOutput {
    func viewDidTapToAddPhotos()
}

class ChooseProductCategoryViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let topSpace: CGFloat = 70
        static let contentInset: CGFloat = 25
    }
    private let categoriesNames: [String] = [Text.Catalog.Categories.clothes,
                                             Text.Catalog.Categories.home,
                                             Text.Catalog.Categories.beauty,
                                             Text.Catalog.Categories.accessories,
                                             Text.Catalog.Categories.electronics,
                                             Text.Catalog.Categories.children,
                                             Text.Catalog.Categories.animals,
                                             Text.Catalog.Categories.sport]
    private var choosenCategory: Int = 0
    // MARK: - Private UI properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 23)
        label.text = Text.Admin.CreateProduct.category
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
    private lazy var nextButton: BaseButton = {
        let button = BaseButtonWithIcon()
        button.setLabelText(text: Text.continue)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
        presenter.viewDidTapToAddPhotos()
    }
    var presenter: AdminPresenter
    init(presenter: AdminPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private functions
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: String(describing: FilterTableViewCell.self))
        [cancelButton, infoLabel, categoryTableView, nextButton].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 5)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.contentInset + 5)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(430)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(2 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
extension ChooseProductCategoryViewController: UITableViewDelegate, UITableViewDataSource {
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

