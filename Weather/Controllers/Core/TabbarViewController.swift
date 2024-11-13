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
        
        let vc1 = CityViewController()
        let vc2 = MainWeatherViewController()
        let vc3 = SettingViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "chart.bar.horizontal.page.fill")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "gearshape")
        
        tabBar.tintColor = .systemOrange
        tabBar.backgroundColor = UIColor(red: 38/255, green: 33/255, blue: 69/255, alpha: 1)
        tabBar.isTranslucent = false
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
        selectedIndex = 1
    }

}
