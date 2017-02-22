//
//  BaseAddViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2017-02-03.
//  Copyright © 2017 Mark Torii. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseAddViewController: UIViewController {
    var textFields: [AnyObject] = []
    var activeTextField: UITextField?
    
    var throttleInterval: RxTimeInterval = 0.1
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupView()
        setupObservables()
    }
    
    private func setupNavigationBar() {
        let doneNavigationButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.rightBarButtonItems = [doneNavigationButton]
    }
    
    func setupView() {
        setupConstraints()
    }
    
    func setupConstraints() {
        // Override me
    }
    
    func setupObservables() {
        // Override me
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
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
    
    func doneTapped() {
        // Nothing to do here.
    }
}


// MARK: UITextFieldDelegate
extension BaseAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField;
        textField.inputAccessoryView = keyboardToolbar()
        return true
    }
}
