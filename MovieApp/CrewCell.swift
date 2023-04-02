//
//  CrewCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import Foundation
import UIKit
import PureLayout

class CrewCell: UICollectionViewCell {
    
    let name = UILabel()
    let role = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        create()
        style()
        layout()
    }
    
    private func create() {
        self.addSubview(name)
        self.addSubview(role)
    }
    
    private func style() {
        name.font = UIFont.boldSystemFont(ofSize: 14)
        role.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func layout() {
        name.autoPinEdge(toSuperviewEdge: .leading)
        name.autoPinEdge(toSuperviewEdge: .trailing)
        name.autoPinEdge(toSuperviewEdge: .top)
        
        role.autoPinEdge(.top, to: .bottom, of: name)
        role.autoPinEdge(toSuperviewEdge: .leading)
        role.autoPinEdge(toSuperviewEdge: .trailing)
        role.autoPinEdge(toSuperviewEdge: .bottom)
        role.autoMatch(.height, to: .height, of: name)
    }
    
    public func setText(name n: String, role r: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        name.attributedText = NSMutableAttributedString(string: n, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        role.attributedText = NSMutableAttributedString(string: r, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
