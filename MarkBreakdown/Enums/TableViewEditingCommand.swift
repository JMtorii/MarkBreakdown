//
//  TableViewEditingCommand.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-03-02.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation

enum TableViewEditingCommand {
    case delete(indexPath: IndexPath)
    case move(from: IndexPath, to: IndexPath)
}
