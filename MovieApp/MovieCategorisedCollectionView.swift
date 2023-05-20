//
//  MovieCategorisedCollectionView.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategorisedCollectionView: UIView {
    
    private var categoryCollectionView: UICollectionView!
    private var categoryLabel: UILabel!
    private var movieList: [MovieModel]!
    private var categoryString: String!
    
    private var movieDetailsRouter: MovieDetailsRouter!
    
    init(category: String, listOfMovies: [MovieModel], router: MovieDetailsRouter) {
        super.init(frame: .zero)
        movieDetailsRouter = router
        categoryString = category
        movieList = listOfMovies
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        categoryString = ""
        movieList = []
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        categoryLabel = UILabel()
        addSubview(categoryLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 122, height: 179)
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: MovieImageCell.reuseIdentifier)
        addSubview(categoryCollectionView)
    }
    
    private func styleViews() {
        categoryLabel.text = categoryString
        categoryLabel.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    private func defineLayout() {
        categoryLabel.autoPinEdge(toSuperviewEdge: .top)
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading)
        categoryLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        categoryCollectionView.autoPinEdge(.top, to: .bottom, of: categoryLabel, withOffset: 16)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        categoryCollectionView.autoSetDimension(.height, toSize: 179)
    }
}

extension MovieCategorisedCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: MovieImageCell.reuseIdentifier, for: indexPath) as? MovieImageCell else { fatalError() }
        let movie = movieList[indexPath.item]
        cell.setData(imageURL: movie.imageUrl, id: movie.id, router: movieDetailsRouter)
        
        return cell
    }
}
