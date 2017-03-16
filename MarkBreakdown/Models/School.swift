//
//  School.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-03-16.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class School: Mappable {
    
    var terms: [Term] {
        didSet {
            termsObservable.value = terms
        }
    }
    
    var termsObservable: Variable<[Term]> = Variable([])
    
    init(terms: [Term]) {
        self.terms = terms;
    }
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        terms <- map["temrs"]
    }
}
