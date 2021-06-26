//
//  FTabBarController.swift
//  FoodApp
//
//  Created by maxim panteleev on 26.06.2021.
//

import UIKit

enum TabBarViewControllers {
    case SearchVC, FavoritesVC
}

class FTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [SearchVC(), FavoritesVC()]
        tabBar.isHidden = true
    }
    
    func presentVC(viewController: TabBarViewControllers) {
        switch viewController {
        case .SearchVC:
            selectedIndex = 0
        case .FavoritesVC:
            selectedIndex = 1
        }
    }
}
