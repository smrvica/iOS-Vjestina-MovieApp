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
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openDetails(movieId: Int) {
        let viewController = MovieDetailsViewController(movieId: movieId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
