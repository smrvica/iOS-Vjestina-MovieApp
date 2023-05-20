//
//  MovieBanner.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieBanner: UIView {
    
    private let score = UILabel()
    private let userScore = UILabel()
    private let title = UILabel()
    private let date = UILabel()
    private let categories = UILabel()
    private let star = UIButton()
    private var imageBackground = UIImageView()
    private var categoriesStr = ""
    
    private var details: MovieDetailsModel?
    
    init(details: MovieDetailsModel?) {
        self.details = details
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.details = nil
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        create()
        style()
        layout()
    }
    
    private func create() {
        guard let details else { return }
        Task {
            await loadImage(imageURL: details.imageUrl, imageView: imageBackground)
        }
        score.text = String(details.rating)
        self.addSubview(score)
        
        userScore.text = "User Score"
        self.addSubview(userScore)
        
        let movieTitle = NSMutableAttributedString(string: details.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        movieTitle.append(NSMutableAttributedString(string: String(format: " (%d)", details.year), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]))
        title.attributedText = movieTitle
        self.addSubview(title)
        
        let dateString = details.releaseDate
        let dateForm0 = DateFormatter()
        let dateForm1 = DateFormatter()
        dateForm0.dateFormat = "yyyy-MM-dd"
        dateForm1.dateFormat = "MM/dd/yyyy"
        let dateChange = dateForm0.date(from: dateString)
        if dateChange != nil {
            date.text = dateForm1.string(from: dateChange!)
        }
        self.addSubview(date)
        
        let category = details.categories
        categoriesStr = category
            .map { (category: MovieCategoryModel) -> String in return capitalSplitString(string: String(describing: category)).capitalized }
            .joined(separator: ", ")
        let catText = NSMutableAttributedString(string: categoriesStr, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        catText.append(NSMutableAttributedString(string: String(format: " %dh %dm", details.duration / 60, details.duration % 60), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        categories.attributedText = catText
        self.addSubview(categories)
        
        self.addSubview(star)
        self.addSubview(imageBackground)
        self.sendSubviewToBack(imageBackground)
    }
    
    private func style() {
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.clipsToBounds = true
        
        score.textColor = .white
        score.font = UIFont.boldSystemFont(ofSize: 16)
        
        userScore.textColor = .white
        userScore.font = UIFont.systemFont(ofSize: 14)
        
        title.textColor = .white
        
        date.textColor = .white
        date.font = UIFont.systemFont(ofSize: 14)
        
        categories.textColor = .white
        
        let starImage = UIImage(systemName: "star")
        star.setImage(starImage, for: .normal)
        star.imageView?.alpha = 1
        star.tintColor = .white
        star.alpha = 0.6
        star.layer.backgroundColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1).cgColor
        star.layer.cornerRadius = 32 / 2
    }
    
    private func layout() {
        imageBackground.autoPinEdgesToSuperviewEdges()
        imageBackground.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        score.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        score.autoPinEdge(toSuperviewEdge: .top, withInset: 134)
        score.autoSetDimension(.height, toSize: 19)
        
        userScore.autoAlignAxis(.horizontal, toSameAxisOf: score)
        userScore.autoPinEdge(.leading, to: .trailing, of: score, withOffset: 8)
        
        title.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        title.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        title.autoPinEdge(.top, to: .bottom, of: score, withOffset: 16)
        title.autoSetDimension(.width, toSize: self.frame.size.width - 40)
        title.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        date.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        date.autoPinEdge(.top, to: .bottom, of: title, withOffset: 16)
        date.autoSetDimension(.height, toSize: 20)
        
        categories.autoPinEdge(.top, to: .bottom, of: date)
        categories.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        categories.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        categories.numberOfLines = 1
        categories.lineBreakMode = .byWordWrapping
        
        star.autoPinEdge(.top, to: .bottom, of: categories, withOffset: 16)
        star.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        star.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        star.autoSetDimension(.width, toSize: 32)
        star.autoSetDimension(.height, toSize: 32)
    }
    
    func loadImage (imageURL: String, imageView: UIImageView) async {
        do {
            let url = URL(string: imageURL)
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            imageBackground.image = image
        } catch {
            return
        }
    }
    
    private func capitalSplitString(string: String) -> String{
        let splitString  = string.reduce("") { (acc, cur) in
            if (cur.isUppercase) {
                return acc + " " + String(cur.lowercased())
            } else {
                return acc + String(cur)
            }
        }
        return splitString
    }
}
