//
//  CustomTextField.swift
//  store
//
//  Created by Evelina on 01.07.2023.
//

import UIKit

class PasswordTextField: TextFieldWithIcon {
    var isShowPassword = false
    var originalText: String? = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCloseButton()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let passwordInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: passwordInset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: passwordInset)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: passwordInset)
    }
    private func addCloseButton() {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 90, y: 10, width: 33, height: 30))
        let eyeImage = UIImage(named: "eyeIcon")
        button.setImage(eyeImage, for: .normal)
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        self.addSubview(button)
    }
    @objc func eyeButtonTapped() {
        if isShowPassword {
            originalText = self.text
            isShowPassword = false
            self.text = String(repeating: "*", count: originalText?.count ?? 0)
        } else {
            self.text = originalText
            isShowPassword = true
        }
    }
}
