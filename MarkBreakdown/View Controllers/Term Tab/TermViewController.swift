//
//  ViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-24.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import StatefulViewController

class TermViewController: UIViewController, StatefulViewController, UITableViewDelegate {
    
    private var tableView: UITableView!
    
    private let disposeBag = DisposeBag()

    
    // MARK: View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupEmptyView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()
    }
    
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TermViewController.addButtonTapped))
        let editButton = self.editButtonItem
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
    }
    
    private func setupEmptyView() {
        emptyView = DefaultEmptyView(title: "You Have No Terms", subTitle: "Tap the + button to add a new term")
    }

    private func setupView() {
        title = "Marks"
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        setupContraints()
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView])))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView])))
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    
    // MARK: Navigation bar button actions
    
    func addButtonTapped(sender: UIButton) {
        print("Add Button pressed")
        let addTermViewController = AddTermViewController()
        navigationController?.pushViewController(addTermViewController, animated: true)
    }
    
    
    // MARK: StatefulViewController methods
    
    func hasContent() -> Bool {
        return false
    }
    
    // MARK: UITableView methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        
        if editing {
            // Nothing to do here?
        }
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

