//
//  MainTabBarViewController.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
