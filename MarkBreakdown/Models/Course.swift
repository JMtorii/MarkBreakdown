//
//  Course.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-01-01.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper

class Course : Mappable {
    
    var courseCode: String?
    var courseName: String?
    var maxPercentage: Int?
    var assessments = [Assessment]()
    
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        courseCode        <- map["courseCode"]
        courseName        <- map["courseName"]
        maxPercentage     <- map["maxPercentage"]
    }
}
