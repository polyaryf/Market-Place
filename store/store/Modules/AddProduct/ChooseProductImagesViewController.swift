//
//  ChooseProductImagesViewController.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import UIKit

protocol ChooseProductImagesViewProtocol {
    func viewDidTapToAddName()
}

class ChooseProductImagesViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let checkBoxWidthHeight: CGFloat = 30
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let textFieldWidth: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
    }
    private var images: [Data] = [UIImage(named: "addImage")?.pngData() ?? Data()]
    let photoManager = PhotoManager()
    // MARK: - Private UI properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 23)
        label.text = Text.Admin.CreateProduct.view
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
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private lazy var nextButton: BaseButton = {
        let button = BaseButtonWithIcon()
        button.setLabelText(text: Text.continue)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .white
        return view
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @objc func nextButtonTapped() {
        presenter.viewDidTapToAddName()
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
    private func startLoading() {
        nextButton.isEnabled = false
        nextButton.setLabelText(text: "")
        nextButton.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(15)
        }
        loadingView.startAnimating()
    }
    private func stopLoading() {
        nextButton.isEnabled = true
        loadingView.stopAnimating()
        nextButton.setLabelText(text: Text.continue)
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        [cancelButton, infoLabel, imagesCollectionView, nextButton].forEach({view.addSubview($0)})
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
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.contentInset + 5)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalTo(nextButton.snp.top).inset(UIConstants.contentInset)
        }
    }
}
extension ChooseProductImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 15
        let itemHeight = 180
        let itemWidth = collectionViewWidth / 2
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between columns
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between rows
    }
}
extension ChooseProductImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self),
            for: indexPath) as? ProductImageCollectionViewCell else { return ProductImageCollectionViewCell()}
        cell.configure(with: images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoManager.delegate = self
        if indexPath.row == images.count - 1 && images.count < 11 {
            startLoading()
            photoManager.getPhotoFromLibrary { [weak self] picker in
                self?.present(picker, animated: true)
            }
        }
    }
}
extension ChooseProductImagesViewController: PhotoManagerDelegate {
    func didChooseImages(images: [UIImage]) {
        let imageArray = images.map({$0.pngData() ?? Data()})
        self.images.insert(contentsOf: imageArray, at: 0)
        imagesCollectionView.reloadData()
        stopLoading()
    }
}
