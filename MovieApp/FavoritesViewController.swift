//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 08.05.2023..
//

import Foundation
import UIKit
import PureLayout
import Combine

class FavoritesViewController: UIViewController {
    
    private let router: MovieDetailsRouter
    private var viewModel: FavoritesViewModel
    
    private var favoritesList: [MovieModel]! = []
    private var favoritesCollectionView: UICollectionView!
    private var favoritesLabel: UILabel!
    
    private var disposable = Set<AnyCancellable>()
    
    init(router: MovieDetailsRouter, viewModel: FavoritesViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildViews()
        bindData()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        favoritesLabel = UILabel()
        view.addSubview(favoritesLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 114, height: 167)
        
        favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        favoritesCollectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: MovieImageCell.reuseIdentifier)
        view.addSubview(favoritesCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        favoritesLabel.text = "Favorites"
        favoritesLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func defineLayout() {
        favoritesLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)
        favoritesLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 23)
        favoritesLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 23)
        
        favoritesCollectionView.autoPinEdge(.top, to: .bottom, of: favoritesLabel, withOffset: 20)
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        favoritesCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func bindData() {
        viewModel.$favorites.sink { [weak self] movies in
            self?.favoritesList = movies
            DispatchQueue.main.async {
                self?.favoritesCollectionView.reloadData()
            }
        }.store(in: &disposable)
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieImageCell.reuseIdentifier, for: indexPath) as? MovieImageCell else { fatalError() }
        let movie = favoritesList[indexPath.item]
        cell.setData(imageURL: movie.imageUrl, id: movie.id, router: router, isFavorite: true) { [weak self] id in self?.viewModel.changeFavorite(id: id)}
        return cell
    }
}
