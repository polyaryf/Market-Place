//
//  Extensions.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import UIKit

extension UIImage {
    func scaledToSize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
