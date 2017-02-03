//
//  AddTermViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-24.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class AddTermViewController: BaseAddViewController {
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var contentView: UIView!
    fileprivate var stackView: UIStackView!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var termNameTextField: SkyFloatingLabelTextField!
    fileprivate var yearTextField: SkyFloatingLabelTextField!
    
    
    // MARK: Setup
    
    override func setupView() {
        title = "Add a New Term"
        view.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20.0
        contentView.addSubview(stackView)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Fill in all fields to add a new course."
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        stackView.addArrangedSubview(descriptionLabel)
        
        termNameTextField = SkyFloatingLabelTextField()
        termNameTextField.translatesAutoresizingMaskIntoConstraints = false
        termNameTextField.placeholder = "Term Name"
        termNameTextField.title = "Term Name"
        termNameTextField.returnKeyType = .done
        termNameTextField.delegate = self
        textFields.append(termNameTextField)
        stackView.addArrangedSubview(termNameTextField)
        
        yearTextField = SkyFloatingLabelTextField()
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.placeholder = "Max Mark Percentage"
        yearTextField.title = "Max Mark Percentage"
        yearTextField.keyboardType = .numberPad
        textFields.append(yearTextField)
        stackView.addArrangedSubview(yearTextField)
        
        super.setupView()
    }
    
    override func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["view": view,
                                          "scrollView": scrollView,
                                          "contentView": contentView,
                                          "stackView": stackView,
                                          "descriptionLabel": descriptionLabel,
                                          "termNameTextField": termNameTextField,
                                          "yearTextField": yearTextField]
        
        // horizontal
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==view)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[stackView]-40-|", metrics: nil, views: views)))
        
        // vertical
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(==view@250)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionLabel(==80)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[termNameTextField(==50)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[yearTextField(==termNameTextField)]", metrics: nil, views: views)))
        
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    override func doneTapped() {
        self.view.endEditing(true)
        
        var hasError = false
        
        if termNameTextField.text?.isEmpty ?? true {
            termNameTextField.errorMessage = "Term Name Required"
            hasError = true
        }
        
        if yearTextField.text?.isEmpty ?? true {
            yearTextField.errorMessage = "Year Required"
            hasError = true
        }
        
        if hasError {
            return;
        }
        
        // TODO: create a new term
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
