//
//  SearchViewController.swift
//  store
//
//  Created by Evelina on 03.07.2023.
//

import UIKit

protocol SearchViewOutput {
    func viewDidTapToAddProductToCart(with index: Int)
    func viewDidTapToOpenFilters()
}

class SearchViewController: BaseViewController, UISearchResultsUpdating {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        filterProducts(searchText: searchController.searchBar.text ?? "")
    }
    private func filterProducts(searchText: String) {
        filteredProducts = presenter.products.filter { product in
            product.name.lowercased().contains(searchText.lowercased())
        }
        productCollectionView.reloadData()
    }
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let checkBoxWidthHeight: CGFloat = 30
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let textFieldWidth: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
    }
    var presenter: CatalogPresenter
    var filteredProducts: [ShortProduct] = []
    init(presenter: CatalogPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
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
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupView()
    }
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Text.Catalog.search
        navigationItem.searchController = searchController
        searchController.searchBar.addSubview(filterButton)
        searchController.searchBar.delegate = self
    }
    private func setupView() {
        view.backgroundColor = .white
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCollectionViewCell.self,
                                       forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self))
        [searchTextField, productCollectionView].forEach({view.addSubview($0)})
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        setupConstraints()
        searchTextField.isHidden = true
    }
    @objc func filterButtonTapped() {
        presenter.viewDidTapToOpenFilters()
    }
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.leading.equalToSuperview().inset(2.5 * UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        filterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset - 6)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 10)
            make.width.height.equalTo(15)
        }
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalToSuperview().offset(UIConstants.contentInset)
        }
    }
}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredProducts.count
        } else {
            return presenter.products.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductCollectionViewCell.self),
            for: indexPath) as? ProductCollectionViewCell else { return ProductCollectionViewCell()}
        cell.delegate = self
        if isFiltering {
            cell.configure(with: filteredProducts[indexPath.row], isUserAdmin: false)
        } else {
            cell.configure(with: presenter.products[indexPath.row], isUserAdmin: false)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // открытие товара
    }
}
extension SearchViewController: ProductCellDelegate {
    func didTapToAddProductToCart(cell: ProductCollectionViewCell) {
        guard let indexPath = productCollectionView.indexPath(for: cell) else {return}
        presenter.viewDidTapToAddProductToCart(with: indexPath.row)
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        filterButton.isHidden = true
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        filterButton.isHidden = false
        return true
    }
}
