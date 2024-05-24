//
//  ReviewView.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import UIKit

class ReviewView: UIView {
    private lazy var firstStarButton: UIButton = {
        let button = UIButton()
        let tintedImage =  UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "emptyStarColor")
        button.tag = 0
        return button
    }()
    private lazy var secondStarButton: UIButton = {
        let button = UIButton()
        let tintedImage =  UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "emptyStarColor")
        button.tag = 1
        return button
    }()
    private lazy var thirdStarButton: UIButton = {
        let button = UIButton()
        let tintedImage =  UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "emptyStarColor")
        button.tag = 2
        return button
    }()
    private lazy var fouthStarButton: UIButton = {
        let button = UIButton()
        let tintedImage =  UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "emptyStarColor")
        button.tag = 3
        return button
    }()
    private lazy var fifthStarButton: UIButton = {
        let button = UIButton()
        let tintedImage =  UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "emptyStarColor")
        button.tag = 4
        return button
    }()
    private var starArray: [UIButton] = []
    var rating: Int = 0
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private function
    private func initialize() {
        backgroundColor = .white
        layer.cornerRadius = 15
        starArray = [firstStarButton, secondStarButton, thirdStarButton, fouthStarButton, fifthStarButton]
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.spacing = 3
        starArray.forEach({xStack.addArrangedSubview($0)})
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        starArray.forEach({ star in
            star.snp.makeConstraints { make in
                make.width.height.equalTo(50)
            }
        })
        starArray.forEach({
            $0.addTarget(self, action: #selector(imageTapped(_:)), for: .touchUpInside)
        })
    }
    private func changeStarColor(tags: [Int], color: UIColor) {
        tags.forEach { tag in
            UIView.animate(withDuration: 0.2) {
                self.starArray[tag].tintColor = color
            }
        }
    }
    @objc func imageTapped(_ sender: UIButton) {
        let tagArray = [0, 1, 2, 3, 4]
        rating = sender.tag + 1
        let lessTags = tagArray.filter({$0 <= sender.tag})
        let moreTags = tagArray.filter({$0 > sender.tag})
        changeStarColor(tags: lessTags, color: UIColor(named: "yellowColor") ?? UIColor())
        changeStarColor(tags: moreTags, color: UIColor(named: "emptyStarColor") ?? UIColor())
    }
}
