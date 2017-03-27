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
    
    var topView: UIView!
    var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    fileprivate var topViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
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
    
    func setupData() {
        // Nothing to do here
    }
    
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TermViewController.addButtonTapped))
        let editButton = self.editButtonItem
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
    }
    
    func setupEmptyView() {
        // Nothing to do here
    }
    
    func setupView() {
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else {
            return
        }
        
        navigationController?.navigationBar.isTranslucent = false
        
        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        tableView = UITableView()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
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
        let views: [String: AnyObject] = ["topView": topView,
                                          "tableView": tableView]
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topView][tableView]|", metrics: nil, views: views)))
        
        topViewHeightConstraint = NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0.0)
        layoutContraints.append(topViewHeightConstraint)
        
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    
    // MARK: Navigation bar button actions
    func addButtonTapped(sender: UIButton) {
        // Nothing to do here
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
}

extension BaseTableViewController {
    func setTopViewHeight(_ height: CGFloat) {
        topViewHeightConstraint.isActive = false
        topViewHeightConstraint = NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        topViewHeightConstraint.isActive = true
        self.view.layoutIfNeeded()
    }
    
    func hideTopView() {
        setTopViewHeight(0.0)
    }
}

// MARK: StatefulViewController delegates
extension BaseTableViewController: StatefulViewController {
    func hasContent() -> Bool {
        return false;
    }
}
