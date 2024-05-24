//
//  CatalogViewController.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit
protocol CatalogViewOutput {
    func viewDidTapToOpenCategory(with index: Int)
}

class CatalogViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let contentInset: CGFloat = 16
        static let textFieldWidth: CGFloat = 20
        static let textFieldHeight: CGFloat = 50
    }
    private var catalogPresenter: CatalogPresenter
    init(presenter: CatalogPresenter) {
        self.catalogPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var searchTextField: UITextField = {
        let textField = TextFieldWithIcon()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = UIConstants.textFieldCornerRadius
        textField.placeholder = Text.Catalog.search
        textField.setImagetoLeft(image: UIImage(named: "searchIcon") ?? UIImage(),
                                 pointX: -22, pointY: -10, width: 85, height: 85)
        textField.backgroundColor = .white
        return textField
    }()
    private lazy var catalogLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 40)
        label.text = Text.Catalog.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var categoryCollectionView: UICollectionView = {
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
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        searchTextField.delegate = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        view.addSubview(searchTextField)
        view.addSubview(catalogLabel)
        view.addSubview(categoryCollectionView)
        setupConstraints()
    }
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        catalogLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(catalogLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalToSuperview().offset(UIConstants.contentInset)
        }
    }
}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogPresenter.categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CategoryCollectionViewCell.self),
            for: indexPath) as? CategoryCollectionViewCell else { return CategoryCollectionViewCell()}
        cell.configure(with: catalogPresenter.categories[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        catalogPresenter.viewDidTapToOpenCategory(with: indexPath.row)
    }
}
extension CatalogViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        catalogPresenter.viewDidTapToOpenCategory(with: 0)
    }
}
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 30
        let itemHeight = 150
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
        return 13 // Set the desired spacing between rows
    }
}
