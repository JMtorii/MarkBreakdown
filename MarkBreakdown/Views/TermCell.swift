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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        termNameLabel.text = ""
        yearLabel.text = ""
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
        termNameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        termNameLabel.textColor = .gray
        contentView.addSubview(termNameLabel)
        
        yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        contentView.addSubview(yearLabel)
        
        setupContraints()
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["termNameLabel": termNameLabel,
                                          "yearLabel": yearLabel]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[termNameLabel]-[yearLabel]-20-|", metrics: nil, views: views)))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[termNameLabel]-15-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[yearLabel(==termNameLabel)]-15-|", metrics: nil, views: views)))

        
        NSLayoutConstraint.activate(layoutContraints)
    }
}
