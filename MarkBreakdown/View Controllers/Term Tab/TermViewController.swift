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

class TermViewController: BaseSplitTableViewController {
    
    var viewModel: TermViewModel = TermViewModel()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setTopViewHeight(10.0)
//    }
    
//    override func setupData() {
//        PersistenceKit.readFromDevice()
//    }
    
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
        setTopViewHeight(10.0)
        tableView.separatorColor = UIColor(white: 0.96, alpha: 1.0)
    }
    
    override func setupCellConfiguration() {
        tableView.register(TermCell.self, forCellReuseIdentifier: TermCell.Identifier)
        
        SchoolManager.sharedInstance.school.termsObservable.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: TermCell.Identifier, cellType: TermCell.self)) { row, term, cell in
                cell.configureWithTerm(term: term)
                cell.selectionStyle = .none
            }.addDisposableTo(disposeBag)
        
        tableView.rx
            .modelSelected(Term.self).subscribe(onNext: { [weak self] term in
                let nextViewController = TermDetailViewConroller(term: term)
                self?.navigationController?.pushViewController(nextViewController, animated: true)
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

