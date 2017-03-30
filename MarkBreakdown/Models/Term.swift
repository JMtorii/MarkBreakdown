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
    var dateAdded: Date?
    var dateModified: Date?
    var average: Float?
    var courses = [Course]()
    
    
    init(termName: String, year: Int, courses: [Course]) {
        self.termName = termName
        self.year = year
        self.courses = courses
        
        dateAdded = Date()
        dateModified = dateAdded
        average = 0
    }
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        termName        <- map["termName"]
        year            <- map["year"]
        dateAdded       <- (map["dateAdded"], DateTransform())
        dateModified    <- (map["dateModified"], DateTransform())
        average         <- map["average"]
        courses         <- map["courses"]
    }
}
