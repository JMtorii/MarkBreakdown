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

class AddTermViewController: UIViewController, UITextFieldDelegate {
    
    private var descriptionLabel: UILabel!
    private var courseCodeTextField: SkyFloatingLabelTextField!
    private var courseNameTextField: SkyFloatingLabelTextField!
    private var maxPercentageTextField: SkyFloatingLabelTextField!
    
    
    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneNavBarTapped))
        
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    private func setupView() {
        title = "Add a New Term"
        view.backgroundColor = .white
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Fill in all fields to add a new course."
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        courseCodeTextField = SkyFloatingLabelTextField()
        courseCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        courseCodeTextField.placeholder = "Course Code"
        courseCodeTextField.title = "Course Code"
        courseCodeTextField.returnKeyType = .done
        courseCodeTextField.delegate = self
        view.addSubview(courseCodeTextField)
        
        courseNameTextField = SkyFloatingLabelTextField()
        courseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextField.placeholder = "Course Name"
        courseNameTextField.title = "Code Name"
        courseNameTextField.returnKeyType = .done
        courseNameTextField.delegate = self
        view.addSubview(courseNameTextField)
        
        maxPercentageTextField = SkyFloatingLabelTextField()
        maxPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
        maxPercentageTextField.placeholder = "Max Mark Percentage"
        maxPercentageTextField.title = "Max Mark Percentage"
        maxPercentageTextField.keyboardType = .numberPad
        maxPercentageTextField.inputAccessoryView = keyboardToolbar()
        view.addSubview(maxPercentageTextField)
        
        setupConstraints() 
    }
    
    private func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide,
                                          "descriptionLabel": descriptionLabel,
                                          "courseCodeTextField": courseCodeTextField,
                                          "courseNameTextField": courseNameTextField,
                                          "maxPercentageTextField": maxPercentageTextField]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[descriptionLabel]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: ["descriptionLabel": descriptionLabel])))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[courseCodeTextField]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: ["courseCodeTextField": courseCodeTextField])))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[courseNameTextField]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: ["courseNameTextField": courseNameTextField])))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[maxPercentageTextField]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: ["maxPercentageTextField": maxPercentageTextField])))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-20-[descriptionLabel]-10-[courseCodeTextField(40)]-20-[courseNameTextField(==courseCodeTextField)]-20-[maxPercentageTextField(==courseCodeTextField)]", options: .alignAllLeading, metrics: nil, views: views)))
        
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    
    // MARK: Selectors
    
    func doneNavBarTapped(sender: UIButton) {
        let term: Term = Term(courseCode: courseCodeTextField.text!, courseName: courseNameTextField.text!, maxPercentage: Int(maxPercentageTextField.text!)!)
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func doneToolbarTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    // MARK: Helpers
    
    private func keyboardToolbar() -> UIToolbar {
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddTermViewController.doneToolbarTapped))
        keyboardDoneButtonView.items = [doneButton]
        
        return keyboardDoneButtonView
    }
    
    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false;
    }
}
