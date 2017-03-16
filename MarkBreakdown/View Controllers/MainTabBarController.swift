//
//  MainTabBarController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-25.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        // First tab
        let termViewController = TermViewController()
        let tabOneNavigationController = UINavigationController(rootViewController: termViewController)
        let tabOneBarItem = UITabBarItem(title: "Marks", image: UIImage(named: "Calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOneNavigationController.tabBarItem = tabOneBarItem
        
        // Second tab
        let settingsViewController = SettingsViewController()
        let tabTwoNavigationController = UINavigationController(rootViewController: settingsViewController)
        let tabTwoBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings"), selectedImage: UIImage(named: "selectedImage.png"))
        tabTwoNavigationController.tabBarItem = tabTwoBarItem
        
        viewControllers = [tabOneNavigationController, tabTwoNavigationController]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
    }
}
