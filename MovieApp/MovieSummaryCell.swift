//
//  MovieSummaryCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout

class MovieSummaryCell: UICollectionViewCell {
    
    private var movieNameLabel: UILabel!
    private var movieSummaryLabel: UILabel!
    private var movieImage: UIImageView!
    
    static let reuseIdentifier = String(describing: MovieSummaryCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    public func setData(name: String, summary: String, imageURL: String) {
        movieNameLabel.text = name
        movieSummaryLabel.text = summary
        Task {
            await loadImage(imageURL: imageURL, imageView: movieImage)
        }
    }
    
    private func createViews() {
        movieNameLabel = UILabel()
        contentView.addSubview(movieNameLabel)
        movieSummaryLabel = UILabel()
        contentView.addSubview(movieSummaryLabel)
        movieImage = UIImageView()
        contentView.addSubview(movieImage)
    }
    
    private func styleViews() {
        backgroundColor = .white
        movieNameLabel.font = .boldSystemFont(ofSize: 16)
        
        movieSummaryLabel.font = .systemFont(ofSize: 14)
        movieSummaryLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieSummaryLabel.numberOfLines = 5
        movieSummaryLabel.lineBreakMode = .byTruncatingTail
        
        movieImage.contentMode = .scaleAspectFill
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        layer.shadowColor = CGColor(gray: 0, alpha: 0.1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func defineLayout() {
        movieImage.autoPinEdge(toSuperviewEdge: .top)
        movieImage.autoPinEdge(toSuperviewEdge: .bottom)
        movieImage.autoPinEdge(toSuperviewEdge: .leading)
        movieImage.autoSetDimension(.width, toSize: 97)
        
        movieNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        movieNameLabel.autoPinEdge(.leading, to: .trailing, of: movieImage, withOffset: 16)
        
        movieSummaryLabel.autoPinEdge(.top, to: .bottom, of: movieNameLabel, withOffset: 8)
        movieSummaryLabel.autoPinEdge(.leading, to: .trailing, of: movieImage, withOffset: 16)
        movieSummaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
    }
    
    private func loadImage(imageURL: String, imageView: UIImageView) async {
        do {
            let url = URL(string: imageURL)
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            imageView.image = image
        } catch {
            return
        }
    }
}
