//
//  MasterDataSource.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-03.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift


class MasterDataSource {
    
    static let sharedInstance : MasterDataSource = {
        let instance = MasterDataSource(terms: []);
        return instance;
    }()
    
    var terms: [Term] = []
    
    private init(terms: [Term]) {
        self.terms = terms
    }
    
}
