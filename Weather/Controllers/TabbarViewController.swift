//
//  TabbarViewController.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/28.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = MainWeatherViewController()
        let vc2 = SettingViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "gearshape")
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: true)
    }

}
