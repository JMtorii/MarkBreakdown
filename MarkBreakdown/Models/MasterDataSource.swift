//
//  MasterDataSource.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-03.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift


class MasterDataSource {
    
    static let sharedInstance : MasterDataSource = {
        let instance = MasterDataSource(terms: []);
        return instance;
    }()
    
    var terms: Variable<[Term]> = Variable([])
    
    private init(terms: [Term]) {
        self.terms = Variable(terms)
    }
    
    static func executeCommand(_ command: TableViewEditingCommand) {
        switch command {
        case let .delete(indexPath):
            MasterDataSource.sharedInstance.terms.value.remove(at: indexPath.row)
        case let .move(from, to):
            let term = MasterDataSource.sharedInstance.terms.value[from.row]
            MasterDataSource.sharedInstance.terms.value.remove(at: from.row)
            MasterDataSource.sharedInstance.terms.value.insert(term, at: to.row)
        }
    }
}

extension MasterDataSource: CustomStringConvertible {
    public var description: String {
        var str: String = "";
        
        str.append("MasterDataSource, count: \(terms.value.count) \n");
        
        terms.value.forEach { term in
            if let year = term.year, let termName = term.termName {
                str.append("\(year): \(termName) \n")
            }
        }
        
        return str;
    }
}
