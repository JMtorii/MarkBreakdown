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
    var name: String?
    var year: Int?
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        name        <- map["username"]
        year        <- map["age"]
    }
}
