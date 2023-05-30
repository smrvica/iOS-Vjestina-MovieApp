//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController: UIViewController {
    
    private var movieCollectionView: UICollectionView!
    private var movieList: [MovieAppData.MovieModel]!
    
    private let movieDetailsRouter: MovieDetailsRouter
    
    init(router: MovieDetailsRouter) {
        movieDetailsRouter = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load info
        let useCase = MovieUseCase()
        movieList = useCase.allMovies
        // build screen
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        // create collection view and configure properties
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.itemSize = CGSize(width: view.bounds.width - 32, height: 142)
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieSummaryCell.self, forCellWithReuseIdentifier: MovieSummaryCell.reuseIdentifier)
        view.addSubview(movieCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        navigationItem.title = "Movie List"
    }
    
    private func defineLayout() {
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .leading)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieSummaryCell.reuseIdentifier, for: indexPath) as? MovieSummaryCell else { fatalError() }
        let movie = movieList[indexPath.item]
        cell.setData(name: movie.name, summary: movie.summary, imageURL: movie.imageUrl,id: movie.id,router: movieDetailsRouter)
        
        return cell
    }
}
