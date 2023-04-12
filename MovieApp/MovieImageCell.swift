//
//  MovieImageCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout

class MovieImageCell : UICollectionViewCell {
    
    var movieImage : UIImageView!
    var heartButton : UIButton!
    var heartImageView : UIImageView!
    
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
    
    public func setData(imageURL: String) {
        Task {
            await loadImage(imageURL: imageURL, imageView: movieImage)
        }
    }
    
    private func createViews() {
        movieImage = UIImageView()
        contentView.addSubview(movieImage)
        heartButton = UIButton()
        contentView.addSubview(heartButton)
        heartImageView = UIImageView()
        heartButton.addSubview(heartImageView)
    }
    
    private func styleViews() {
        let heartImage = UIImage(systemName: "heart")
        heartImageView.image = heartImage
        heartImageView.tintColor = .white
        heartButton.alpha = 0.6
        heartButton.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        heartButton.layer.cornerRadius = 32 / 2
        
        movieImage.contentMode = .scaleAspectFill
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true // maybe masks to bounds
    }
    
    private func defineLayout() {
        movieImage.autoPinEdgesToSuperviewEdges()
        
        heartImageView.autoCenterInSuperview()
        
        heartButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        heartButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        heartButton.autoSetDimension(.height, toSize: 32)
        heartButton.autoSetDimension(.width, toSize: 32)
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
