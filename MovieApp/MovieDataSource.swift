//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by endava-bootcamp on 21.05.2023..
//

import Foundation
import MovieAppData

class MovieDataSource {
    
    private var useCase = MovieAppData.MovieUseCase()
    private let baseURL = "https://five-ios-api.herokuapp.com"
    
    func fetchPopularMovies() async -> [MovieModel] {
        return useCase.popularMovies
    }
    
    func fetchFreeMovies() async -> [MovieModel] {
        return useCase.freeToWatchMovies
    }
    
    func fetchTrendingMovies() async -> [MovieModel] {
        return useCase.trendingMovies
    }
    
    func fetchMovieDetails(id: Int) async -> MovieDetailsModel? {
        return useCase.getDetails(id: id)
    }
}
