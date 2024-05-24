//
//  PriceTextField.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import UIKit

class PriceTextField: RegularTextField {
    let textFieldsInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldsInsets)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldsInsets)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldsInsets)
    }
    func addLeftText(text: String, pointX: Int, pointY: Int, width: Int, height: Int) {
        let label = UILabel(frame: CGRect(x: pointX, y: pointY, width: width, height: height))
        label.text = text
        label.font = UIFont.init(name: "MontserratRoman-Medium", size: 16)
        label.textColor = UIColor(named: "placeholderTextColor")
        self.addSubview(label)
    }
}
