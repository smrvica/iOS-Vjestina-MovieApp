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
    private var eMailInput: InputField!
    private var passInput: InputField!
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
        eMailInput = InputField(labelText: "Email address", placeHolder: "ex. Matt@iosCourse.com")
        view.addSubview(eMailInput)
        passInput = InputField(labelText: "Password", placeHolder: "Enter your password")
        view.addSubview(passInput)
        signInButton = UIButton()
        view.addSubview(signInButton)
    }
    
    private func styleViews() {
        view.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "Sign in"
        titleLabel.textAlignment = .center
        
        signInButton.backgroundColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        
    }
    
    private func defineLayout() {
        titleLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 92)

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

    }
}
