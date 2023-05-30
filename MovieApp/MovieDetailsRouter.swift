//
//  MovieDetailsRouter.swift
//  MovieApp
//
//  Created by endava-bootcamp on 09.05.2023..
//

import Foundation
import UIKit

class MovieDetailsRouter {
    
    private let navigationController: UINavigationController
    private let movieDataSource: MovieDataSource
    
    init(with navigationController: UINavigationController, dataSource: MovieDataSource) {
        movieDataSource = dataSource
        self.navigationController = navigationController
    }
    
    func openDetails(movieId: Int) {
        let detailsViewModel = MovieDetailsViewModel(movieDataSource: movieDataSource, id: movieId)
        let viewController = MovieDetailsViewController(movieId: movieId, viewModel: detailsViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
