//
//  MovieCategorisedViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategorisedViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var stackView: UIStackView!
    
    private var moviePopularList: [MovieModel]!
    private var moviePopularCollectionView: MovieCategorisedCollectionView!
    private var movieFreeList: [MovieModel]!
    private var movieFreeCollectionView: MovieCategorisedCollectionView!
    private var movieTrendingList: [MovieModel]!
    private var movieTrendingCollectionView: MovieCategorisedCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load info
        let useCase = MovieUseCase()
        moviePopularList = useCase.popularMovies
        movieFreeList = useCase.freeToWatchMovies
        movieTrendingList = useCase.trendingMovies
        // build screen
        buildViews()
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
        
        moviePopularCollectionView = MovieCategorisedCollectionView(category: "What's popular", listOfMovies: moviePopularList)
        stackView.addArrangedSubview(moviePopularCollectionView)
        movieFreeCollectionView = MovieCategorisedCollectionView(category: "Free to watch", listOfMovies: movieFreeList)
        stackView.addArrangedSubview(movieFreeCollectionView)
        movieTrendingCollectionView = MovieCategorisedCollectionView(category: "Trending", listOfMovies: movieTrendingList)
        stackView.addArrangedSubview(movieTrendingCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
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
}
