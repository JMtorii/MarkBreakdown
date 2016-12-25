//
//  SettingsViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-25.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "Settings View Controller"
        
        view.backgroundColor = .blue
    }
}
