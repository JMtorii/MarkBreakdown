//
//  School.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-03.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import RxSwift


class SchoolManager {
    static let sharedInstance: SchoolManager = SchoolManager(school: School(terms: []))
    var school: School
    
    
    private init(school: School) {
        self.school = school
    }
}
