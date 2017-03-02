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

    override func setupEmptyView() {
        emptyView = DefaultEmptyView(title: "You Have No Terms", subTitle: "Tap the + button to add a new term")
    }
    
    override func setupView() {
        title = "Terms"
        
        super.setupView()
    }
    
    override func setupCellConfiguration() {
        for index in 1...5 {
            let testTerm = Term(termName: "Test Term \(index)", year: 2017, courses: [])
            MasterDataSource.sharedInstance.terms.value.append(testTerm)
        }

        tableView.register(TermCell.self, forCellReuseIdentifier: TermCell.Identifier)
        
//        let moveTermCommand = tableView.rx.itemMoved.map()
        
        MasterDataSource.sharedInstance.terms.asObservable().bindTo(tableView.rx.items(cellIdentifier: TermCell.Identifier, cellType: TermCell.self)) { row, term, cell in
            cell.configureWithTerm(term: term)
        }.addDisposableTo(disposeBag)
    }
    
    override func setupCellTapped() {
        tableView.rx.modelSelected(Term.self).subscribe(onNext: { term in
            // Do stuff here
        }).addDisposableTo(disposeBag)
    }
    
    override func addButtonTapped(sender: UIButton) {
        print("Add Button pressed")
        let addTermViewController = AddTermViewController()
        navigationController?.pushViewController(addTermViewController, animated: true)
    }
}


// MARK: StatefulViewController delegates
extension TermViewController  {
    override func hasContent() -> Bool {
        return MasterDataSource.sharedInstance.terms.value.count > 0
    }
}

