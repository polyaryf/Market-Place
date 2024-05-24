//
//  FilterCheckBox.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit
import SnapKit

final class FilterCheckBox: UIView {
    private enum UIConstants {
        static let checkBoxImageHeightWidth: CGFloat = 20
    }
    var isCheck: Bool = false
    private lazy var checkmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkmarkIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawView() {
        self.layer.cornerRadius = self.frame.height / 2
        backgroundColor = UIColor.white
        addSubview(checkmarkImage)
        checkmarkImage.isHidden = true
        checkmarkImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(UIConstants.checkBoxImageHeightWidth)
            make.height.equalTo(UIConstants.checkBoxImageHeightWidth)
        }
    }
    func check() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor(named: "greenColor")
            self.checkmarkImage.isHidden = false
        }
        isCheck = true
    }
    func uncheck() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor.white
            self.checkmarkImage.isHidden = true
        }
        isCheck = false
    }
}
