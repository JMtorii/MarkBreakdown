//
//  AddTermViewController.swift
//  MarkBreakdown
//
//  Created by Mark Torii on 2016-12-24.
//  Copyright © 2016 Mark Torii. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddTermViewController: BaseAddViewController {
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var contentView: UIView!
    fileprivate var stackView: UIStackView!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var termNameTextField: PlaceholderTextField!
    fileprivate var yearTextField: PlaceholderTextField!
    
    
    // MARK: Setup
    
    override func setupView() {
        title = "Add a New Term"
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        
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
        stackView.spacing = 0.0
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
        
        addSeparator(height: 0.5)
        
        termNameTextField = PlaceholderTextField()
        termNameTextField.translatesAutoresizingMaskIntoConstraints = false
        termNameTextField.placeholder = "Term Name"
        termNameTextField.returnKeyType = .done
        termNameTextField.autocorrectionType = .no
        termNameTextField.delegate = self
        termNameTextField.backgroundColor = .white
        textFields.append(termNameTextField)
        stackView.addArrangedSubview(termNameTextField)
        
        addSeparator(height: 0.5)
        
        yearTextField = PlaceholderTextField()
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.placeholder = "Year"
        yearTextField.keyboardType = .numberPad
        yearTextField.delegate = self;
        yearTextField.backgroundColor = .white
        textFields.append(yearTextField)
        stackView.addArrangedSubview(yearTextField)
        
        addSeparator(height: 0.5)
        
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
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", metrics: nil, views: views)))
        
        // vertical
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(==view@250)]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionLabel(==80)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[termNameTextField(==50)]", metrics: nil, views: views)))
        layoutContraints.append(contentsOf:(NSLayoutConstraint.constraints(withVisualFormat: "V:[yearTextField(==termNameTextField)]", metrics: nil, views: views)))

        NSLayoutConstraint.activate(layoutContraints)
    }
    
    override func setupObservables() {
        let termNameValid = termNameTextField.rx.text.throttle(throttleInterval, scheduler: MainScheduler.instance).map {
            !($0?.isEmpty ?? true)
        }
        
        let yearValid = yearTextField.rx.text.throttle(throttleInterval, scheduler: MainScheduler.instance).map {
            !($0?.isEmpty ?? true) && $0?.characters.count == 4
        }
        
        let everythingValid = Observable.combineLatest(termNameValid, yearValid) {
            $0 && $1
        }
        
        everythingValid.bindTo(navigationItem.rightBarButtonItem!.rx.isEnabled).addDisposableTo(disposeBag)
    }
    
    override func doneTapped() {
        self.view.endEditing(true)
        
        if let navigationController = navigationController, let termName = termNameTextField.text, let year = yearTextField.text, let intYear = Int(year) {
            let term: Term = Term(termName: termName, year: intYear, courses: [])
            SchoolManager.sharedInstance.school.terms.append(term)
            PersistenceKit.persistToDevice()
            
            navigationController.popViewController(animated: true)
        }
    }
    
    func addSeparator(height: CGFloat) {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.init(white: 0.8, alpha: 1.0)
        stackView.addArrangedSubview(separator)
        
        NSLayoutConstraint(item: separator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5).isActive = true
    }
}

extension AddTermViewController: UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == yearTextField) {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        
        return true
    }
}
