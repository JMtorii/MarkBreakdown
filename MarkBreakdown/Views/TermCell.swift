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
    
    var containerView: UIView!
    var mainStackView: UIStackView!
    var leftStackView: UIStackView!
    
    var yearLabel: UILabel!
    var dateModifiedLabel: UILabel!
    var termNameLabel: UILabel!
    var averageLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        yearLabel.text = ""
        dateModifiedLabel.text = ""
        termNameLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            containerView.backgroundColor = .gray
        } else {
            containerView.backgroundColor = .white
        }
    }
    
    func configureWithTerm(term: Term) {
        if let year = term.year {
            yearLabel.text = "\(year)"
        }
        
        if let termName = term.termName {
            termNameLabel.text = termName
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
        
        mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        mainStackView.spacing = 0.0
        containerView.addSubview(mainStackView)
        
        // left stack view content
        leftStackView = UIStackView()
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .vertical
        leftStackView.distribution = .fill
        leftStackView.alignment = .fill
        leftStackView.spacing = 0.0
        mainStackView.addArrangedSubview(leftStackView)
        
        yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        leftStackView.addArrangedSubview(yearLabel)
        
        dateModifiedLabel = UILabel()
        dateModifiedLabel.translatesAutoresizingMaskIntoConstraints = false
        dateModifiedLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        leftStackView.addArrangedSubview(dateModifiedLabel)
        
        termNameLabel = UILabel()
        termNameLabel.translatesAutoresizingMaskIntoConstraints = false
        termNameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        termNameLabel.textColor = .gray
        leftStackView.addArrangedSubview(termNameLabel)
        
        // right view
        averageLabel = UILabel()
        averageLabel.translatesAutoresizingMaskIntoConstraints = true
        averageLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        mainStackView.addArrangedSubview(averageLabel)
        
        setupContraints()
    }
    
    private func setupContraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["containerView": containerView,
                                          "mainStackView": mainStackView,
                                          "leftStackView": leftStackView]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[containerView]-20-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainStackView]|", metrics: nil, views: views)))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[containerView]-5-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainStackView]|", metrics: nil, views: views)))

        
        NSLayoutConstraint.activate(layoutContraints)
    }
}
