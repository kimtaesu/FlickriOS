//
//  HomeViewContoller.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Hero
import UIKit

class HomeViewContoller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryViewController = createCategoryViewController()
        let searchViewController = createSearchViewController()
        self.hero.isEnabled = true
        self.hero.tabBarAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .pull(direction: .right))
        viewControllers = [categoryViewController, searchViewController]
    }
    
    private func createSearchViewController() -> SearchViewController {
        return SearchViewController().then {
            $0.tabBarItem = UITabBarItem().then {
                $0.title = "Search"
                $0.image = Asset.icSearch.image
            }
        }
    }
    private func createCategoryViewController() -> CategoryViewController {
        return CategoryViewController().then {
            $0.tabBarItem = UITabBarItem().then {
                $0.title = "Popular"
                $0.image = Asset.icHome.image
            }
        }
    }
}
