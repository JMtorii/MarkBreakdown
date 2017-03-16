//
//  PersistenceKit.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-03-16.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation

class PersistenceKit {
    
    static let dataKey = "MarkBreakdownDataKey"
    
    static func persistToDevice() {
        UserDefaults.standard.set(SchoolManager.sharedInstance.school.toJSONString(), forKey: dataKey)
    }
    
    static func readFromDevice() {
        let json = UserDefaults.standard.object(forKey: dataKey) as! String
        SchoolManager.sharedInstance.school = School(JSON: json)
    }
}
