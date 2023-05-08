//
//  inputField.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import Foundation
import UIKit
import PureLayout

class InputField: UIView {
    
    private var fieldLabel: UILabel!
    private let labelText: String
    private var inputField: UITextField!
    private let placeHolder: String
    
    let color = UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1)
    
    init(labelText: String, placeHolder: String) {
        self.labelText = labelText
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.labelText = ""
        self.placeHolder = ""
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        fieldLabel = UILabel()
        self.addSubview(fieldLabel)
        inputField = UITextField()
        self.addSubview(inputField)
    }
    
    private func styleViews() {
        
        fieldLabel.text = labelText
        fieldLabel.textColor = .white
        fieldLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        inputField.font = UIFont.systemFont(ofSize: 16)
        inputField.textColor = color
        inputField.backgroundColor = UIColor(red: 19/255, green: 59/255, blue: 99/255, alpha: 1)
        inputField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
        inputField.layer.borderColor = CGColor(red: 21/255, green: 77/255, blue: 133/255, alpha: 1)
        inputField.layer.borderWidth = 1
        inputField.layer.shadowColor = UIColor.black.cgColor
        inputField.layer.shadowOffset = CGSize(width: 0, height: 1)
        inputField.layer.shadowOpacity = 0.09
        inputField.layer.shadowRadius = 3
        inputField.layer.cornerRadius = 10
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 48))
        inputField.leftView = padding
        inputField.leftViewMode = .always
        inputField.rightView = padding
        inputField.rightViewMode = .always
    }
    
    private func defineLayout() {
        fieldLabel.autoPinEdge(toSuperviewEdge: .top)
        fieldLabel.autoPinEdge(toSuperviewEdge: .leading)
        fieldLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        inputField.autoPinEdge(toSuperviewEdge: .bottom)
        inputField.autoPinEdge(toSuperviewEdge: .leading)
        inputField.autoPinEdge(toSuperviewEdge: .trailing)
        inputField.autoSetDimension(.height, toSize: 48)
        inputField.autoPinEdge(.top, to: .bottom, of: fieldLabel, withOffset: 8)
    }
    
}
