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
    
    fileprivate var accessiblePlaceholderLabel: UILabel!
    
    fileprivate var accessiblePlaceholderTopConstraint: NSLayoutConstraint!
    
    override var text: String? {
        get {
            return super.text
        }
        set {
            super.text = newValue
            updatePlaceholder(isAnimated: true)
        }
    }
    
    override var placeholder: String? {
        get {
            return super.placeholder
        }
        set {
            super.placeholder = newValue
            accessiblePlaceholderLabel.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholderText: String) {
        super.init(frame: CGRect.zero)
        
        setup(withPlaceholder: placeholderText)
    }
    
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

// MARK: helper methods
extension PlaceholderTextField {
    fileprivate func setup(withPlaceholder placeholderText:String) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        // left view
//        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 10.0))
//        leftViewMode = .always
//        leftView = spacerView
        
        // placeholder
        accessiblePlaceholderLabel = UILabel()
        accessiblePlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        accessiblePlaceholderLabel.text = placeholderText
        accessiblePlaceholderLabel.alpha = 0.0
        addSubview(accessiblePlaceholderLabel)
        
        let views: [String: AnyObject] = ["accessiblePlaceholderLabel": accessiblePlaceholderLabel]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[accessiblePlaceholderLabel]-20-|", metrics: nil, views: views))
        
        accessiblePlaceholderTopConstraint = NSLayoutConstraint.init(item: accessiblePlaceholderLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 15.0)
        accessiblePlaceholderTopConstraint.isActive = true
        
        // set placeholder text
        placeholder = placeholderText
    }
    
    fileprivate func updatePlaceholder(isAnimated: Bool) {
        guard let text = self.text else {
            return
        }
        
        if text.characters.count > 0 && accessiblePlaceholderLabel.alpha == 0.0 {
            layoutIfNeeded()
            accessiblePlaceholderTopConstraint.constant = 7.0
            
            if isAnimated {
                UIView.animate(withDuration: 0.3, animations: {
                    self.accessiblePlaceholderLabel.alpha = 1.0
                    self.layoutIfNeeded()
                })
            } else {
                accessiblePlaceholderLabel.alpha = 1.0
            }
            
        } else if text.characters.count == 0 && accessiblePlaceholderLabel.alpha == 1 {
            layoutIfNeeded()
            accessiblePlaceholderTopConstraint.constant = 15.0
            
            if isAnimated {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.layoutIfNeeded()
                    self.accessiblePlaceholderLabel.alpha = 0.0
                })
            } else {
                accessiblePlaceholderLabel.alpha = 0.0
            }
        }
    }
}
