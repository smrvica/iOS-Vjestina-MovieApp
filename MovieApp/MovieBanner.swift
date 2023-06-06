//
//  MovieBanner.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import Foundation
import UIKit
import PureLayout

class MovieBanner: UIView {
    
    private var score: UILabel!
    private var userScore: UILabel!
    private var title: UILabel!
    private var date: UILabel!
    private var categories: UILabel!
    var heart: UIButton!
    private var imageBackground: UIImageView!
    private var categoriesStr = ""
    
    private var details: MovieDetailsModel? = nil
    
    init() {
        super.init(frame: .zero)
        configure()
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
        score = UILabel()
        addSubview(score)
        
        userScore = UILabel()
        addSubview(userScore)
        
        title = UILabel()
        addSubview(title)
        
        date = UILabel()
        addSubview(date)
        
        categories = UILabel()
        addSubview(categories)
        
        heart = UIButton()
        addSubview(heart)
                
        imageBackground = UIImageView()
        addSubview(imageBackground)
        sendSubviewToBack(imageBackground)
    }
    
    private func style() {
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.clipsToBounds = true
        
        score.textColor = .white
        score.font = UIFont.boldSystemFont(ofSize: 16)
        
        userScore.text = "User Score"
        userScore.textColor = .white
        userScore.font = UIFont.systemFont(ofSize: 14)
        
        title.textColor = .white
        
        date.textColor = .white
        date.font = UIFont.systemFont(ofSize: 14)
        
        categories.textColor = .white
        
        heart.imageView?.alpha = 1
        heart.tintColor = .white
        heart.alpha = 0.6
        heart.layer.backgroundColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1).cgColor
        heart.layer.cornerRadius = 32 / 2
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
        
        heart.autoPinEdge(.top, to: .bottom, of: categories, withOffset: 16)
        heart.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        heart.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        heart.autoSetDimension(.width, toSize: 32)
        heart.autoSetDimension(.height, toSize: 32)
    }
    
    func loadImage (imageURL: String, imageView: UIImageView) async {
        guard let URL = URL(string: imageURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: URL)
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        } catch {
            print("Error loading image: \(error)")
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
    
    func setDetails(details: MovieDetailsModel?) {
        self.details = details
        guard let details else { return }
        
        Task {
            await loadImage(imageURL: details.imageUrl, imageView: imageBackground)
        }
        score.text = String(details.rating)
        
        let movieTitle = NSMutableAttributedString(string: details.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        movieTitle.append(NSMutableAttributedString(string: String(format: " (%d)", details.year), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]))
        title.attributedText = movieTitle
        
        let dateString = details.releaseDate
        let dateForm0 = DateFormatter()
        let dateForm1 = DateFormatter()
        dateForm0.dateFormat = "yyyy-MM-dd"
        dateForm1.dateFormat = "MM/dd/yyyy"
        let dateChange = dateForm0.date(from: dateString)
        if dateChange != nil {
            date.text = dateForm1.string(from: dateChange!)
        }
        
        let category = details.categories
        categoriesStr = category
            .map { (category: MovieCategoryModel) -> String in return capitalSplitString(string: String(describing: category)).capitalized }
            .joined(separator: ", ")
        let catText = NSMutableAttributedString(string: categoriesStr, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        catText.append(NSMutableAttributedString(string: String(format: " %dh %dm", details.duration / 60, details.duration % 60), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        categories.attributedText = catText
    }
    
    func changeFavorite(favorite: Bool) {
        var heartImage: UIImage?
        
        if favorite {
            heartImage = UIImage(systemName: "heart.fill")
        } else {
            heartImage = UIImage(systemName: "heart")
        }
        heart.setImage(heartImage, for: .normal)
    }
}
