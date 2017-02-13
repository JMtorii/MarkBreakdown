//
//  PlaceholderTextField.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-13.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import UIKit
import Foundation

class PlaceholderTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.insetBy(dx: 0, dy: 2).offsetBy(dx: 20, dy: 4);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.insetBy(dx: 0, dy: 2).offsetBy(dx: 20, dy: 4);
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        return bounds.offsetBy(dx: 20, dy: 2);
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        let caretRect: CGRect = super.caretRect(for: position)
        if let text = self.text, text.characters.count > 0 {
            return caretRect
        }
        
        return caretRect.offsetBy(dx: 0, dy: -3)
    }
}
