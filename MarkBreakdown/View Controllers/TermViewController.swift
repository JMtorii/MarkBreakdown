//
//  ViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-24.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import UIKit
import RxSwift

class TermViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationView() {
//        let addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style: UIBarButtonItemStyleBordered target:self action:@selector(addORDoneRows)];
        
//        let addButton = new UIBarButtonItem(
//        [self.navigationItem setLeftBarButtonItem:addButton];
    }

    private func setupView() {
        title = "Term View Controller"
        
        view.backgroundColor = .white
    }
}

