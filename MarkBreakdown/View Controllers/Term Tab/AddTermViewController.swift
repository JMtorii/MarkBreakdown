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

class AddTermViewController: UIViewController {
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var contentView: UIView!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var courseCodeTextField: SkyFloatingLabelTextField!
    fileprivate var courseNameTextField: SkyFloatingLabelTextField!
    fileprivate var maxPercentageTextField: SkyFloatingLabelTextField!
    fileprivate var testView: UIView!
    
    
    fileprivate var textFields: [AnyObject] = []
    fileprivate var activeTextField: UITextField?
    
    
    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped(sender:)))
        
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    private func setupView() {
        title = "Add a New Term"
        view.backgroundColor = .white
        
//        edgesForExtendedLayout = [.bottom, .top]
//        automaticallyAdjustsScrollViewInsets = false
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, (tabBarController?.tabBar.frame.height)!, 0)       // TODO: safety unwrap
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Fill in all fields to add a new course."
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        contentView.addSubview(descriptionLabel)
        
        courseCodeTextField = SkyFloatingLabelTextField()
        courseCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        courseCodeTextField.placeholder = "Course Code"
        courseCodeTextField.title = "Course Code"
        courseCodeTextField.returnKeyType = .done
        courseCodeTextField.delegate = self
        textFields.append(courseCodeTextField)
        contentView.addSubview(courseCodeTextField)
        
        courseNameTextField = SkyFloatingLabelTextField()
        courseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextField.placeholder = "Course Name"
        courseNameTextField.title = "Course Name"
        courseNameTextField.returnKeyType = .done
        courseNameTextField.delegate = self
        textFields.append(courseNameTextField)
        contentView.addSubview(courseNameTextField)
        
        maxPercentageTextField = SkyFloatingLabelTextField()
        maxPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
        maxPercentageTextField.placeholder = "Max Mark Percentage"
        maxPercentageTextField.title = "Max Mark Percentage"
        maxPercentageTextField.keyboardType = .numberPad
        textFields.append(maxPercentageTextField)
        contentView.addSubview(maxPercentageTextField)
        
        testView = UIView()
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.backgroundColor = .blue
        contentView.addSubview(testView)
        
        setupConstraints() 
    }
    
    private func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["view": view,
                                          "scrollView": scrollView,
                                          "contentView": contentView,
                                          "descriptionLabel": descriptionLabel,
                                          "courseCodeTextField": courseCodeTextField,
                                          "courseNameTextField": courseNameTextField,
                                          "maxPercentageTextField": maxPercentageTextField,
                                          "testView": testView]
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==view)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[descriptionLabel]-40-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[courseCodeTextField]-40-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[courseNameTextField]-40-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[maxPercentageTextField]-40-|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[testView]-40-|", metrics: nil, views: views)))
        
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(==view@250)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[descriptionLabel]-10-[courseCodeTextField(40)]-20-[courseNameTextField(==courseCodeTextField)]-20-[maxPercentageTextField(==courseCodeTextField)]-20-[testView(==450)]", metrics: nil, views: views)))
        
        NSLayoutConstraint.activate(layoutContraints)
    }
    
    // TODO: Move elsewhere
    // TODO: Optimize, we create this every single time a textfield is selected
    func keyboardToolbar() -> UIToolbar {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        // spacers
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        // done button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped(sender:)))
        
        // error check state
        guard let activeTextField = activeTextField else {
            // toolbar with done button only
            toolbar.setItems([flexibleSpaceButton, doneButton], animated: false)
            return toolbar
        }
        
        // Figure out if the textField is first or last
        let isFirst = activeTextField == textFields[0] as? UITextField
        let isLast = activeTextField == textFields[self.textFields.count - 1] as? UITextField
        
        // previousButton
        let previousButton = UIBarButtonItem(image: UIImage(named: "Toolbar-Back"), style: .plain, target: self, action: #selector(previousButttonToolbarTapped))
        previousButton.isEnabled = !isFirst
        
        // nextButton
        let nextButton = UIBarButtonItem(image: UIImage(named: "Toolbar-Forward"), style: .plain, target: self, action: #selector(nextButtonToolbarTapped))
        nextButton.isEnabled = !isLast
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: false)
        return toolbar
    }
    
    
    // MARK: Selectors
    
    func doneTapped(sender: AnyObject) {
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
    
    func previousButttonToolbarTapped(sender: AnyObject) {
        print("Previous button pressed")
        
        if let activeTextField = activeTextField, let index = textFields.index(where: {$0 === activeTextField}), index != textFields.startIndex {
            _ = textFields[index - 1].becomeFirstResponder()
        }
    }

    func nextButtonToolbarTapped(sender: AnyObject) {
        print("Next button pressed")
        
        if let activeTextField = activeTextField, let index = textFields.index(where: {$0 === activeTextField}), index != textFields.endIndex {
            _ = textFields[index + 1].becomeFirstResponder()
        }
    }
}


// MARK: UITextFieldDelegate
extension AddTermViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField;
        textField.inputAccessoryView = keyboardToolbar()
        return true
    }
}
