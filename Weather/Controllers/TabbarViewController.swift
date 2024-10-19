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
        
        let vc1 = MapViewController()
        let vc2 = MainWeatherViewController()
        let vc3 = SettingViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "paperplane")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "gearshape")
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
        selectedIndex = 1
    }

}
