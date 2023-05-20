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
    
    private var crewName: UILabel!
    private var crewRole: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        crewName = UILabel()
        self.addSubview(crewName)
        crewRole = UILabel()
        self.addSubview(crewRole)
    }
    
    private func styleViews() {
        crewName.font = UIFont.boldSystemFont(ofSize: 14)
        crewRole.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func defineLayout() {
        crewName.autoPinEdge(toSuperviewEdge: .leading)
        crewName.autoPinEdge(toSuperviewEdge: .trailing)
        crewName.autoPinEdge(toSuperviewEdge: .top)
        
        crewRole.autoPinEdge(.top, to: .bottom, of: crewName)
        crewRole.autoPinEdge(toSuperviewEdge: .leading)
        crewRole.autoPinEdge(toSuperviewEdge: .trailing)
        crewRole.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func setText(name: String, role: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        crewName.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        crewRole.attributedText = NSMutableAttributedString(string: role, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
