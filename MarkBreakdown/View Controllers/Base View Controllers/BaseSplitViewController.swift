//
//  BaseSplitViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-04-26.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import UIKit

class BaseSplitViewController: UIViewController {
    
    var topView: UIView!
    var bottomView: UIView!
    
    var topViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        // top view
        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        // bottom view
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        
        // set up constraints
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["topView": topView,
                                          "bottomView": bottomView]
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topView][bottomView]|", metrics: nil, views: views)))
        
        topViewHeightConstraint = NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0.0)
        layoutContraints.append(topViewHeightConstraint)
        
        NSLayoutConstraint.activate(layoutContraints)
    }
}
