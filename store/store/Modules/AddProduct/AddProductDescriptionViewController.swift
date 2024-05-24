//
//  AddProductDescriptionViewController.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import UIKit

protocol AddProductDescriptionViewOutput {
    func viewDidTapToAddCost()
}

class AddProductDescriptionViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let textFieldCornerRadius: CGFloat = 15
        static let topSpace: CGFloat = 80
        static let textViewWidth: CGFloat = 350
        static let textViewHeight: CGFloat = 200
    }
    var presenter: AdminPresenter
    init(presenter: AdminPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = Text.Admin.CreateProduct.AddDescription.title
        label.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 23)
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.backgroundColor = .white
        textView.text = Text.Admin.CreateProduct.AddDescription.placeholder
        textView.textColor = .lightGray
        textView.font = UIFont.init(name: "MontserratRoman-SemiBold", size: 16)
        textView.layer.cornerRadius = 15
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return textView
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.Filter.cancel, for: .normal)
        button.setTitleColor(UIColor(named: "greenColor"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Montserrat", size: 18) ?? UIFont()
        return button
    }()
    private lazy var nextButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.continue)
        button.backgroundColor = UIColor(named: "baseButtonColor")
        return button
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @objc func nextButtonTapped() {
        if textView.text == Text.Admin.CreateProduct.AddDescription.placeholder {
            textView.layer.borderColor = UIColor.systemRed.cgColor
            textView.layer.borderWidth = 1.0
        }
        presenter.viewDidTapToAddCost()
    }
    // MARK: - Private functions
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        textView.delegate = self
        [cancelButton, infoLabel, textView, nextButton].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset + 5)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset + 4)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(3 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(2 * UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.textViewWidth)
            make.height.equalTo(UIConstants.textViewHeight)
        }
    }
}

extension AddProductDescriptionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        textView.layer.borderColor = UIColor(named: "greenColor")?.cgColor
        textView.layer.borderWidth = 1.3
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Text.Admin.CreateProduct.AddDescription.placeholder
            textView.textColor = UIColor.lightGray
        }
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 0.5
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.text != "" {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "greenColor")
            }
            textView.layer.borderColor = UIColor(named: "greenColor")?.cgColor
            textView.layer.borderWidth = 1.3
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.nextButton.backgroundColor = UIColor(named: "baseButtonColor")
            }
            textView.layer.borderColor = UIColor.systemGray5.cgColor
            textView.layer.borderWidth = 0.5
        }
    }
}
