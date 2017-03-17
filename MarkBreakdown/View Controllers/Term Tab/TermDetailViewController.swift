//
//  TermDetailViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-03-17.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class TermDetailViewConroller : UIViewController {
    
    var term: Term!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(term: Term) {
        super.init(nibName: nil, bundle: nil)
        
        self.term = term
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = term.termName
    }
}
