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
    
//    fileprivate lazy var inputToolbar: UIToolbar = {
//        
//        // Figure out if the textField is first or last
//        var isFirst = false
//        var isLast = false
//        
//        for case let textField as UITextField in self.textFields where textField.isFirstResponder {
//            isFirst = textField == self.textFields[0] as? UITextField
//            isLast = textField == self.textFields[self.textFields.count - 1] as? UITextField
//        }
//        
//        var toolbar = UIToolbar()
//        toolbar.barStyle = .default
//        toolbar.isTranslucent = true
//        toolbar.sizeToFit()
//        
//        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        
//        var previousButton  = UIBarButtonItem(image: UIImage(named: "Toolbar-Back"), style: .plain, target: self, action: #selector(AddTermViewController.previousButttonToolbarTapped))
//        var nextButton  = UIBarButtonItem(image: UIImage(named: "Toolbar-Forward"), style: .plain, target: self, action: #selector(AddTermViewController.nextButtonToolbarTapped))
//        nextButton.width = 50.0
//        
//        var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTermViewController.doneToolbarTapped))
//        
//        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: false)
//        toolbar.isUserInteractionEnabled = true
//        
//        return toolbar
//    }()

    
    
    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        findTextFields()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneNavBarTapped))
        
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
        contentView.addSubview(courseCodeTextField)
        
        courseNameTextField = SkyFloatingLabelTextField()
        courseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        courseNameTextField.placeholder = "Course Name"
        courseNameTextField.title = "Code Name"
        courseNameTextField.returnKeyType = .done
        courseNameTextField.delegate = self
        contentView.addSubview(courseNameTextField)
        
        maxPercentageTextField = SkyFloatingLabelTextField()
        maxPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
        maxPercentageTextField.placeholder = "Max Mark Percentage"
        maxPercentageTextField.title = "Max Mark Percentage"
        maxPercentageTextField.keyboardType = .numberPad
//        maxPercentageTextField.inputAccessoryView = keyboardToolbar()
        contentView.addSubview(maxPercentageTextField)
        
        testView = UIView()
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.backgroundColor = .blue
        contentView.addSubview(testView)
        
        setupConstraints() 
    }
    
    private func findTextFields() {
        textFields = []
        for case let textField as UITextField in self.contentView.subviews {
            textFields.append(textField)
        }
    }
    
    private func setupConstraints() {
        var layoutContraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["view": view,
                                          "topLayoutGuide": topLayoutGuide,
                                          "scrollView": scrollView,
                                          "contentView": contentView,
                                          "descriptionLabel": descriptionLabel,
                                          "courseCodeTextField": courseCodeTextField,
                                          "courseNameTextField": courseNameTextField,
                                          "maxPercentageTextField": maxPercentageTextField,
                                          "testView": testView,
                                          "bottomLayoutGuide": bottomLayoutGuide]
        
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
    
    func keyboardToolbar() -> UIToolbar {
        // Figure out if the textField is first or last
        var isFirst = false
        var isLast = false
        
        for case let textField as UITextField in self.textFields where textField.isFirstResponder {
            isFirst = textField == self.textFields[0] as? UITextField
            isLast = textField == self.textFields[self.textFields.count - 1] as? UITextField
        }
        
        let toolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let previousButton  = UIBarButtonItem(image: UIImage(named: "Toolbar-Back"), style: .plain, target: self, action: #selector(AddTermViewController.previousButttonToolbarTapped))
        if isFirst {
            previousButton.isEnabled = false
        }
        
        
        let nextButton  = UIBarButtonItem(image: UIImage(named: "Toolbar-Forward"), style: .plain, target: self, action: #selector(AddTermViewController.nextButtonToolbarTapped))
        nextButton.width = 50.0
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTermViewController.doneToolbarTapped))
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
    
    
    // MARK: Selectors
    
    func doneNavBarTapped(sender: UIButton) {
//        let term: Term = Term(termName: courseCodeTextField.text!, year: courseNameTextField.text!, courses: Int(maxPercentageTextField.text!)!)
//        
//        if let navigationController = navigationController {
//            navigationController.popViewController(animated: true)
//        }
    }
    
    func doneToolbarTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func previousButttonToolbarTapped(sender: AnyObject) {
        print("Previous button pressed")
        
        for case let textField as UITextField in textFields where textField.isFirstResponder {
            if textField == textFields[0] as? UITextField {
                
            }
        }
    }

    func nextButtonToolbarTapped(sender: AnyObject) {
        print("Next button pressed")
    }
}


// MARK: UITextFieldDelegate
extension AddTermViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        return false;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = keyboardToolbar()
        return true
    }
}
