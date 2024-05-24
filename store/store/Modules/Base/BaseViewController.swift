//
//  BaseViewController.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    private lazy var connectionErrorView: ErrorView = {
        let view = ErrorView(frame: CGRect(x: 50, y: 150, width: 300, height: 310))
        view.setImage(image: UIImage(named: "connectionErrorImage") ?? UIImage())
        view.setButtonTitle(title: Text.refresh)
        view.setText(text: Text.error)
        return view
    }()
}
