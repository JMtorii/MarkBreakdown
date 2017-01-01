//
//  TermCell.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-30.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

class TermCell: UITableViewCell {
    static let Identifier = "TermCell"
    
    var courseCodeLabel: UILabel!
    var courseNameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        courseCodeLabel = UILabel()
        courseCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        courseCodeLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        courseCodeLabel.textColor = .gray
        contentView.addSubview(courseCodeLabel)
        
        courseNameLabel = UILabel()
        courseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(courseNameLabel)
        
        setupContraints()
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["courseCodeLabel": courseCodeLabel,
                                          "courseNameLabel": courseNameLabel]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[courseCodeLabel]-20-[courseNameLabel]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[courseCodeLabel(40)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[courseNameLabel(40)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))

        
        NSLayoutConstraint.activate(layoutContraints)
    }
}
