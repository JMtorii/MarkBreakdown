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
        
        let termViewController = TermViewController()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "Calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        termViewController.tabBarItem = tabOneBarItem
        
        let settingsViewController = SettingsViewController()
        let tabTwoBarItem = UITabBarItem(title: "Tab 2", image: UIImage(named: "Settings"), selectedImage: UIImage(named: "selectedImage.png"))
        settingsViewController.tabBarItem = tabTwoBarItem
        
        viewControllers = [termViewController, settingsViewController]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
