//
//  PlaceholderTextFieldDelegate.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-04-05.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation

protocol PlaceholderTextFieldDelegate {
    func isTextFieldTextValid(_ textField: PlaceholderTextField) -> Bool
}
