//
//  UIStackView+Utilities.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-13.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    public func addSeparator(height: CGFloat, color: UIColor) {
        // For now, we only handle vertical stack views
        guard self.axis == .vertical else {
            return
        }
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = color
        self.addArrangedSubview(separator)
        
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["separator": separator]

        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[separator1(==0.5)]", metrics: nil, views: views)))

        NSLayoutConstraint.activate(layoutContraints)
    }
    
    public func addSpacer(height: CGFloat) {
        // For now, we only handle vertical stack views
        guard self.axis == .vertical else {
            return
        }
        
        let spacer = UIView()
    }
}
