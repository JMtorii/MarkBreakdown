//
//  DefaultEmptyView.swift
//  MarkBreakdown
//
//  Created by Jun Torii on 2017-01-01.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

class DefaultEmptyView: UIView {
    
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, subTitle: String) {
        self.init(frame: .zero)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        self.addSubview(stackView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightBold)
        titleLabel.textColor = UIColor(white: 0.1, alpha: 1.0)
        titleLabel.textAlignment = .center
        
        subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        subTitleLabel.textColor = .black
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        layoutContraints.append(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        layoutContraints.append(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -40.0))
        layoutContraints.append(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        layoutContraints.append(NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))
        NSLayoutConstraint.activate(layoutContraints)
    }
}
