//
//  TermViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-24.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import StatefulViewController

class TermViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()

    
    // MARK: View Controller lifecycle
    
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(tableView)
        
        setupContraints()
    }
    
    private func setupCellConfiguration() {
        let testTerm = Term(termName: "Test Term", year: 2017, courses: [])
        MasterDataSource.sharedInstance.terms.value.append(testTerm)
        
        tableView.register(TermCell.self, forCellReuseIdentifier: TermCell.Identifier)
        
        MasterDataSource.sharedInstance.terms.asObservable().bindTo(tableView.rx.items(cellIdentifier: TermCell.Identifier, cellType: TermCell.self)) { row, term, cell in
            cell.configureWithTerm(term: term)
        }.addDisposableTo(disposeBag)
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
        print("Add Button pressed")
        let addTermViewController = AddTermViewController()
        navigationController?.pushViewController(addTermViewController, animated: true)
    }
}


// MARK: StatefulViewController delegates
extension TermViewController: StatefulViewController {
    func hasContent() -> Bool {
        return MasterDataSource.sharedInstance.terms.value.count > 0
    }
}


// MARK: UITableViewDelegate delegates
//extension TermViewController: UITableViewDelegate {
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        tableView.isEditing = editing
//        
//        if editing {
//            // Nothing to do here?
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//}

