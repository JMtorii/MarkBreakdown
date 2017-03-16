//
//  Term.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-30.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper

class Term : Mappable {
    var termName: String?
    var year: Int?
    var courses = [Course]()
    
    
    init(termName: String, year: Int, courses: [Course]) {
        self.termName = termName
        self.year = year
        self.courses = courses
    }
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        termName        <- map["termName"]
        year            <- map["year"]
        courses         <- map["courses"]
    }
}
