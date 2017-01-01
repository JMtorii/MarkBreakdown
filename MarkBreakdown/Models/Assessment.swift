//
//  Assessment.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-01-01.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper

class Assessment: Mappable {
    
    var name: String?
    var worthPercentage: Int?
    var markReceived: Int?
    
    required init?(map: Map) {
        // Nothing to do here
    }
    
    func mapping(map: Map) {
        name                <- map["name"]
        worthPercentage     <- map["worthPercentage"]
        markReceived        <- map["markReceived"]
    }
}
