//
//  TextFieldWithIcon.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import UIKit

class TextFieldWithIcon: RegularTextField {
    
    let textFieldInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldInset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldInset)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldInset)
    }
    func setImagetoLeft(image: UIImage, pointX: Int, pointY: Int, width: Int, height: Int) {
        self.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: pointX, y: pointY, width: width, height: height))
        imageView.image = image
        self.addSubview(imageView)
    }
}
