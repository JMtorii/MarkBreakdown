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

class BaseSplitTableViewController: BaseSplitViewController {
    
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupEmptyView()
        setupView()
        setupCellConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()
    }
    
    
    // MARK: Setup
    
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BaseSplitTableViewController.addButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    func setupEmptyView() {
        // Nothing to do here
    }
    
    func setupView() {
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else {
            return
        }
        
        navigationController?.navigationBar.isTranslucent = false
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
        tableView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        bottomView.addSubview(tableView)
        
        setupContraints()
    }
    
    func setupCellConfiguration() {
        // Nothing to do here
    }
    
    func addButtonTapped(Sender: UIButton) {
        
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["tableView": tableView]
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", metrics: nil, views: views)))
        
        topViewHeightConstraint = NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0.0)
        layoutContraints.append(topViewHeightConstraint)
        
        NSLayoutConstraint.activate(layoutContraints)
    }
}

extension BaseSplitTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

}

// MARK: Top view
extension BaseSplitTableViewController {
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
extension BaseSplitTableViewController: StatefulViewController {
    func hasContent() -> Bool {
        return false;
    }
}
