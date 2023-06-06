//
//  MovieCategorisedViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout
import Combine

class MovieCategorisedViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var stackView: UIStackView!
    
    private var moviePopularList: [[MovieModel]] = []
    private var moviePopularCollectionView: MovieCategorisedCollectionView!
    private var movieFreeList: [[MovieModel]] = []
    private var movieFreeCollectionView: MovieCategorisedCollectionView!
    private var movieTrendingList: [[MovieModel]] = []
    private var movieTrendingCollectionView: MovieCategorisedCollectionView!
    
    private var favoritesList: [Int] = []
    
    private let movieDetailsRouter: MovieDetailsRouter
    
    private var movieCategorisedViewModel: MovieCategorisedViewModel!
    private var favoritesViewModel: FavoritesViewModel!
    private var disposablesFree = Set<AnyCancellable>()
    private var disposablesPopular = Set<AnyCancellable>()
    private var disposablesTrending = Set<AnyCancellable>()
    private var disposableFav = Set<AnyCancellable>()
    
    init(router: MovieDetailsRouter, viewModel: MovieCategorisedViewModel, favViewModel: FavoritesViewModel) {
        movieDetailsRouter = router
        movieCategorisedViewModel = viewModel
        favoritesViewModel = favViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // build screen
        buildViews()
        // load info
        bindData()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        contentView = UIView()
        scrollView.addSubview(contentView)
        stackView = UIStackView()
        contentView.addSubview(stackView)
        
        moviePopularCollectionView = MovieCategorisedCollectionView(category: "What's popular", listOfMovies: moviePopularList, router: movieDetailsRouter, tags: ["Streaming", "On TV", "For rent", "In theaters"]) { [weak self] id in self?.favoritesViewModel.changeFavorite(id: id)}
        stackView.addArrangedSubview(moviePopularCollectionView)
        
        movieFreeCollectionView = MovieCategorisedCollectionView(category: "Free to watch", listOfMovies: movieFreeList, router: movieDetailsRouter, tags: ["Movies", "TV"]) { [weak self] id in self?.favoritesViewModel.changeFavorite(id: id)}
        stackView.addArrangedSubview(movieFreeCollectionView)
        
        movieTrendingCollectionView = MovieCategorisedCollectionView(category: "Trending", listOfMovies: movieTrendingList, router: movieDetailsRouter, tags: ["Today", "This Week"]) { [weak self] id in self?.favoritesViewModel.changeFavorite(id: id)}
        stackView.addArrangedSubview(movieTrendingCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        navigationItem.title = "Movie List"
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
    }
    
    private func defineLayout() {
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.contentSize = contentView.frame.size
        
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        stackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 27)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func bindData() {
        favoritesViewModel.$favorites.sink { [weak self] movies in
            let ids = movies.map({$0.id})
            self?.favoritesList = ids
            self?.moviePopularCollectionView.setFavoritesList(favorites: ids)
            self?.movieFreeCollectionView.setFavoritesList(favorites: ids)
            self?.movieTrendingCollectionView.setFavoritesList(favorites: ids)
        }.store(in: &disposableFav)
        
        movieCategorisedViewModel.$popularMoviesList.sink { [weak self] movies in
            self?.moviePopularList = movies
            self?.moviePopularCollectionView.setMovieList(movies: self?.moviePopularList ?? [])
        }.store(in: &disposablesPopular)

        movieCategorisedViewModel.$freeMoviesList.sink { [weak self] movies in
            self?.movieFreeList = movies
            self?.movieFreeCollectionView.setMovieList(movies: self?.movieFreeList ?? [])
        }.store(in: &disposablesFree)

        movieCategorisedViewModel.$trendingMoviesList.sink { [weak self] movies in
            self?.movieTrendingList = movies
            self?.movieTrendingCollectionView.setMovieList(movies: self?.movieTrendingList ?? [])
        }.store(in: &disposablesTrending)
    }
}
