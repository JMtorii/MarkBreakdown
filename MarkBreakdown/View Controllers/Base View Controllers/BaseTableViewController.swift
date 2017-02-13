//
//  BaseTableViewController.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-02-12.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import StatefulViewController

class BaseTableViewController: UIViewController {
    
    var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupEmptyView()
        setupView()
        setupCellConfiguration()
        setupCellTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()
    }
    
    
    // MARK: Setup
    
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TermViewController.addButtonTapped))
        let editButton = self.editButtonItem
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
    }
    
    func setupEmptyView() {
        // Nothing to do here
    }
    
    func setupView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(tableView)
        
        setupContraints()
    }
    
    func setupCellConfiguration() {
        // Nothing to do here
    }
    
    func setupCellTapped() {
        // Nothing to do here
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["tableView": tableView]
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", metrics: nil, views: views)))
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    
    // MARK: Navigation bar button actions
    
    func addButtonTapped(sender: UIButton) {
        // Nothing to do here
    }
}

// MARK: StatefulViewController delegates
extension BaseTableViewController: StatefulViewController {
    func hasContent() -> Bool {
        return false;
    }
}
