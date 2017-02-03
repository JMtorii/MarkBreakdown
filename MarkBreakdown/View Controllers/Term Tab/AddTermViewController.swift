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
    fileprivate var courseCodeTextField: SkyFloatingLabelTextField!
    fileprivate var courseNameTextField: SkyFloatingLabelTextField!
    fileprivate var maxPercentageTextField: SkyFloatingLabelTextField!
    fileprivate var testView: UIView!
    
    
    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
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
        stackView.spacing = 10.0
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
        
        courseCodeTextField = SkyFloatingLabelTextField()
        courseCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        courseCodeTextField.placeholder = "Course Code"
        courseCodeTextField.title = "Course Code"
        courseCodeTextField.returnKeyType = .done
        courseCodeTextField.delegate = self
        textFields.append(courseCodeTextField)
        stackView.addArrangedSubview(courseCodeTextField)
        
        courseNameTextField = SkyFloatingLabelTextField()
        courseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextField.placeholder = "Course Name"
        courseNameTextField.title = "Course Name"
        courseNameTextField.returnKeyType = .done
        courseNameTextField.delegate = self
        textFields.append(courseNameTextField)
        stackView.addArrangedSubview(courseNameTextField)
        
        maxPercentageTextField = SkyFloatingLabelTextField()
        maxPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
        maxPercentageTextField.placeholder = "Max Mark Percentage"
        maxPercentageTextField.title = "Max Mark Percentage"
        maxPercentageTextField.keyboardType = .numberPad
        textFields.append(maxPercentageTextField)
        stackView.addArrangedSubview(maxPercentageTextField)
        
        testView = UIView()
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.backgroundColor = .blue
        stackView.addArrangedSubview(testView)
        
        super.setupView()
    }
    
    override func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["view": view,
                                          "scrollView": scrollView,
                                          "contentView": contentView,
                                          "stackView": stackView,
                                          "descriptionLabel": descriptionLabel,
                                          "courseCodeTextField": courseCodeTextField,
                                          "courseNameTextField": courseNameTextField,
                                          "maxPercentageTextField": maxPercentageTextField,
                                          "testView": testView]
        
        // horizontal
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==view)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[stackView]-40-|", metrics: nil, views: views)))
        
        // vertical
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(==view@250)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionLabel(==80)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[courseCodeTextField(==50)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[courseNameTextField(==courseCodeTextField)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[maxPercentageTextField(==courseCodeTextField)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[testView(==700)]", metrics: nil, views: views)))
        
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    override func doneTapped() {
        self.view.endEditing(true)
        
        var hasError = false
        
        if courseCodeTextField.text?.isEmpty ?? true {
            courseCodeTextField.errorMessage = "Course Code Required"
            hasError = true
        }
        
        if courseNameTextField.text?.isEmpty ?? true {
            courseNameTextField.errorMessage = "Course Name Required"
            hasError = true
        }
        
        if maxPercentageTextField.text?.isEmpty ?? true {
            maxPercentageTextField.errorMessage = "Max Percentage Required"
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
