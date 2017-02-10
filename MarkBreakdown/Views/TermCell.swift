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
    
    var termNameLabel: UILabel!
    var yearLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithTerm(term: Term) {
        if let termName = term.termName {
            termNameLabel.text = termName
        }
        
        if let year = term.year {
            yearLabel.text = "\(year)"
        }
    }
    
    private func setupView() {
        termNameLabel = UILabel()
        termNameLabel.translatesAutoresizingMaskIntoConstraints = false
        termNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        termNameLabel.textColor = .gray
        contentView.addSubview(termNameLabel)
        
        yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yearLabel)
        
        setupContraints()
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["termNameLabel": termNameLabel,
                                          "yearLabel": yearLabel]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[termNameLabel]-20-[yearLabel]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[termNameLabel(40)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[termNameLabel(40)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: views)))

        
        NSLayoutConstraint.activate(layoutContraints)
    }
}
