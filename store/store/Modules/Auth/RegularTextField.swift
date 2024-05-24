//
//  RegularTextField.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit

class RegularTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeInnerShadow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    private func makeInnerShadow() {
        let shadowLayer = CAShapeLayer()
        let shadowColor = UIColor.black.cgColor
        let shadowOffset = CGSize(width: 0, height: 0)
        let shadowBlurRadius: CGFloat = 3
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: 5))
        shadowPath.addCurve(
            to: CGPoint(x: 15, y: 0),
            controlPoint1: CGPoint(x: 0, y: 0),
            controlPoint2: CGPoint(x: 0, y: 7.5)
        )
        shadowPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        shadowPath.addCurve(
            to: CGPoint(x: UIScreen.main.bounds.width - 15, y: 0),
            controlPoint1: CGPoint(x: UIScreen.main.bounds.width, y: 0),
            controlPoint2: CGPoint(x: UIScreen.main.bounds.width - 7.5, y: 0)
        )
        layer.masksToBounds = true
        shadowLayer.shadowColor = shadowColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowRadius = shadowBlurRadius
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowOpacity = 0.2
        layer.addSublayer(shadowLayer)
//        layer.shouldRasterize = true
    }
}
