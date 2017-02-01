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
    
    fileprivate lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTermViewController.doneToolbarTapped))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        var nextButton  = UIBarButtonItem(image: UIImage(named: "keyboardPreviousButton"), style: .plain, target: self, action: nil)
        nextButton.width = 50.0
        var previousButton  = UIBarButtonItem(image: UIImage(named: "keyboardNextButton"), style: .plain, target: self, action: nil)
        
        toolbar.setItems([fixedSpaceButton, nextButton, fixedSpaceButton, previousButton, flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()

    
    
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
    
    
    // MARK: Helpers
    
//    private func keyboardToolbar() -> UIToolbar {
//        let keyboardDoneButtonView = UIToolbar()
//        keyboardDoneButtonView.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddTermViewController.doneToolbarTapped))
//        keyboardDoneButtonView.items = [doneButton]
//        
//        return keyboardDoneButtonView
//    }

}


// MARK: UITextFieldDelegate
extension AddTermViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = inputToolbar
        return true
    }
}
