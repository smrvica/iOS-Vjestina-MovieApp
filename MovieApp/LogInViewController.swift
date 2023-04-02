//
//  LogInViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 27.03.2023..
//

import Foundation
import UIKit
import PureLayout

class LogInViewController: UIViewController{
    
    private var titleLabel: UILabel!
//    private var eMailLabel: UILabel!
//    private var passLabel: UILabel!
//    private var eMailField: UITextField!
//    private var passField: UITextField!
    private var eMailInput: inputField!
    private var passInput: inputField!
    private var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
//        eMailLabel = UILabel()
//        view.addSubview(eMailLabel)
//        passLabel = UILabel()
//        view.addSubview(passLabel)
//        eMailField = UITextField()
//        view.addSubview(eMailField)
//        passField = UITextField()
//        view.addSubview(passField)
        eMailInput = inputField(labelText: "Email address", placeHolder: "ex. Matt@iosCourse.com")
        view.addSubview(eMailInput)
        passInput = inputField(labelText: "Password", placeHolder: "Enter your password")
        view.addSubview(passInput)
        signInButton = UIButton()
        view.addSubview(signInButton)
    }
    
    private func styleViews() {
        view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1).cgColor
        
        titleLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.attributedText = NSAttributedString(string: "Sign in")
        titleLabel.textAlignment = .center
        
//        eMailLabel.backgroundColor = UIColor(white: 1, alpha: 0)
//        eMailLabel.textColor = UIColor(white: 1, alpha: 1)
//        eMailLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        eMailLabel.attributedText = NSAttributedString(string: "Email address")
//
//        passLabel.backgroundColor = UIColor(white: 1, alpha: 0)
//        passLabel.textColor = UIColor(white: 1, alpha: 1)
//        passLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        passLabel.attributedText = NSAttributedString(string: "Password")
//
//
//        // should have made this a class since the code is the same and long
//        passField.font = UIFont.systemFont(ofSize: 16)
//        passField.textColor = UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1)
//        passField.backgroundColor = UIColor(red: 19/255, green: 59/255, blue: 99/255, alpha: 1)
//        passField.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1)])
//        passField.layer.borderColor = CGColor(red: 21/255, green: 77/255, blue: 133/255, alpha: 1)
//        passField.layer.borderWidth = 1
//        passField.layer.shadowColor = UIColor.black.cgColor
//        passField.layer.shadowOffset = CGSize(width: 0, height: 1)
//        passField.layer.shadowOpacity = 0.09
//        passField.layer.shadowRadius = 3
//        passField.layer.cornerRadius = 10
//        passField.leftView = padding
//        passField.leftViewMode = .always
//        passField.rightView = padding
//        passField.rightViewMode = .always
//
        signInButton.layer.backgroundColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1).cgColor
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        
    }
    
    private func defineLayout() {
        titleLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        titleLabel.autoSetDimension(.height, toSize: 26)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 92)
        
//        eMailField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
//        eMailField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
//        eMailField.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 76)
//        eMailField.autoSetDimension(.height, toSize: 48)
//
//        passField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
//        passField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
//        passField.autoPinEdge(.top, to: .bottom, of: eMailField, withOffset: 52)
//        passField.autoSetDimension(.height, toSize: 48)

        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
        signInButton.autoPinEdge(.top, to: .bottom, of: passInput, withOffset: 48)
        signInButton.autoSetDimension(.height, toSize: 40)
        
        eMailInput.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        eMailInput.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        eMailInput.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 48)
        
        passInput.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passInput.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passInput.autoPinEdge(.top, to: .bottom, of: eMailInput, withOffset: 24)

//        eMailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
//        eMailLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
//        eMailLabel.autoPinEdge(.bottom, to: .top, of: eMailField, withOffset: 8)
//        eMailLabel.autoSetDimension(.height, toSize: 20)
//
//        passLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
//        passLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
//        passLabel.autoPinEdge(.bottom, to: .top, of: passLabel, withOffset: 8)
//        passLabel.autoSetDimension(.height, toSize: 20)
    }
}
