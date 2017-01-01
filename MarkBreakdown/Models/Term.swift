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
    var courseCode: String?
    var courseName: String?
    var maxPercentage: Int?
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    init(courseCode: String, courseName: String, maxPercentage: Int) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.maxPercentage = maxPercentage
    }
    
    func mapping(map: Map) {
        courseCode        <- map["courseCode"]
        courseName        <- map["courseName"]
        maxPercentage     <- map["maxPercentage"]
    }
}
