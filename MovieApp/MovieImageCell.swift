//
//  MovieImageCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout

class MovieImageCell: UICollectionViewCell {
    
    private var movieImage: UIImageView!
    private var heartButton: UIButton!
    private var heartImageView: UIImageView!
    private var movieButton: UIButton!
    
    private var favorite: Bool!
    private var changeFavorite: ((Int) -> Void)?
    
    private var movieId: Int!
    private var movieDetailsRouter: MovieDetailsRouter!
    
    static let reuseIdentifier = String(describing: MovieImageCell.self)
    
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
    
    public func setData(imageURL: String, id: Int, router: MovieDetailsRouter, isFavorite: Bool, changeFavoriteFunc: @escaping (Int) -> Void) {
        movieId = id
        movieDetailsRouter = router
        favorite = isFavorite
        changeFavorite = changeFavoriteFunc
        DispatchQueue.main.async {
            if self.favorite {
                let heartImage = UIImage(systemName: "heart.fill")
                self.heartImageView.image = heartImage
            } else {
                let heartImage = UIImage(systemName: "heart")
                self.heartImageView.image = heartImage
            }
        }
        Task {
            await loadImage(imageURL: imageURL, imageView: movieImage)
        }
    }
    
    private func createViews() {
        movieButton = UIButton()
        movieButton.addTarget(self, action: #selector(openDetails), for: .touchUpInside)
        contentView.addSubview(movieButton)
        
        movieImage = UIImageView()
        movieButton.addSubview(movieImage)
        
        heartButton = UIButton()
        movieButton.addSubview(heartButton)
        heartButton.addTarget(self, action: #selector(handleChangeFavorite), for: .touchUpInside)
        
        heartImageView = UIImageView()
        heartButton.addSubview(heartImageView)
    }
    
    private func styleViews() {
        
        heartImageView.tintColor = .white
        heartButton.alpha = 0.6
        heartButton.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        heartButton.layer.cornerRadius = 32 / 2
        
        movieImage.contentMode = .scaleAspectFill
        
        layer.cornerRadius = 10
        clipsToBounds = true // maybe masks to bounds
    }
    
    private func defineLayout() {
        movieImage.autoPinEdgesToSuperviewEdges()
        
        heartImageView.autoCenterInSuperview()
        
        heartButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        heartButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        heartButton.autoSetDimension(.height, toSize: 32)
        heartButton.autoSetDimension(.width, toSize: 32)
        
        movieButton.autoPinEdgesToSuperviewEdges()
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
    
    @objc func openDetails() {
        movieDetailsRouter.openDetails(movieId: movieId)
    }
    
    @objc func handleChangeFavorite() {
        changeFavorite?(movieId)
    }
}
