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

class TermViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewHeight(10.0)
    }
    
    override func setupData() {
        PersistenceKit.readFromDevice()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        title = "Terms"
    }
    
    override func setupEmptyView() {
        emptyView = DefaultEmptyView(title: "You Have No Terms", subTitle: "Tap the + button to add a new term")
    }
    
    override func setupView() {
        super.setupView()
        
        topView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
    }
    
    override func setupCellConfiguration() {
        tableView.separatorColor = UIColor(white: 0.96, alpha: 1.0)
        tableView.register(TermCell.self, forCellReuseIdentifier: TermCell.Identifier)
        
        SchoolManager.sharedInstance.school.termsObservable.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: TermCell.Identifier, cellType: TermCell.self)) { row, term, cell in
                cell.configureWithTerm(term: term)
                cell.selectionStyle = .none
            }.addDisposableTo(disposeBag)
        
        tableView.rx
            .itemDeleted
            .subscribe(onNext: { (indexPath: IndexPath) in
                SchoolManager.executeCommand(.delete(indexPath: indexPath))
            }).addDisposableTo(disposeBag)
        
        tableView.rx
            .itemMoved
            .subscribe(onNext: { (sourceIndex: IndexPath, destinationIndex: IndexPath) in
                SchoolManager.executeCommand(.move(from: sourceIndex, to: destinationIndex))
            }).addDisposableTo(disposeBag)
    }
    
    override func setupCellTapped() {
        tableView.rx
            .modelSelected(Term.self).subscribe(onNext: { term in
                // Do stuff here
            }).addDisposableTo(disposeBag)
    }
    
    override func addButtonTapped(sender: UIButton) {
        let addTermViewController = AddTermViewController()
        navigationController?.pushViewController(addTermViewController, animated: true)
    }
}


// MARK: StatefulViewController delegates
extension TermViewController  {
    override func hasContent() -> Bool {
        return SchoolManager.sharedInstance.school.terms.count > 0
    }
}

