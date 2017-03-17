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


// MARK: CustomStringConvertible methods
//extension School : CustomStringConvertible {
//    public var description: String {
//        var str: String = "";
//        
//        str.append("Terms, count: \(school.value.terms.count) \n");
//        
//        school.value.terms.forEach { term in
//            if let year = term.year, let termName = term.termName {
//                str.append("\(year): \(termName) \n")
//            }
//        }
//            
//        return str;
//    }
//}


// MARK: Helper static methods
extension SchoolManager {
    static func executeCommand(_ command: TableViewEditingCommand) {
        switch command {
        case let .delete(indexPath):
            SchoolManager.sharedInstance.school.terms.remove(at: indexPath.row)
        case let .move(from, to):
            let term = SchoolManager.sharedInstance.school.terms[from.row]
            SchoolManager.sharedInstance.school.terms.remove(at: from.row)
            SchoolManager.sharedInstance.school.terms.insert(term, at: to.row)
        }
        
        PersistenceKit.persistToDevice()
    }
}
