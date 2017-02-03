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
    
    static let sharedMasterDataSource = MasterDataSource(terms: [])
    
    var terms: Variable<[Term]> = Variable([])
    
    init(terms: [Term]) {
        self.terms = Variable(terms)
    }
    
}
