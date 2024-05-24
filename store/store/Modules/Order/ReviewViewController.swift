//
//  ReviewViewController.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

class ReviewViewController: BaseViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let topSpace: CGFloat = 130
    }
    private var rating: Int = 0
    var presenter: OrderPresenter
    init(presenter: OrderPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private UI properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.init(name: "MontserratRoman-ExtraBold", size: 40)
        label.text = Text.Review.title
        label.textColor = UIColor(named: "titleTextColor")
        return label
    }()
    private lazy var doneButton: BaseButton = {
        let button = BaseButton()
        button.setLabelText(text: Text.Review.done)
        button.backgroundColor = UIColor(named: "greenColor")
        return button
    }()
    private lazy var reviewView: ReviewView = {
        let view = ReviewView()
        return view
    }()
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @objc func nextButtonTapped() {
        let viewControllers = navigationController?.viewControllers
        guard let targetViewController = viewControllers?[(viewControllers?.count ?? 2) - 3] else {return}
        navigationController?.popToViewController(targetViewController, animated: true)
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        doneButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        [infoLabel, reviewView, doneButton].forEach({view.addSubview($0)})
        setupConstraints()
    }
    private func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topSpace)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(80)
        }
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(4 * UIConstants.contentInset)
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
    }
}
