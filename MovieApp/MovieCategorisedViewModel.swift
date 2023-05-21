//
//  MovieCategorisedViewModel.swift
//  MovieApp
//
//  Created by endava-bootcamp on 21.05.2023..
//

import Foundation
import MovieAppData

class MovieCategorisedViewModel: ObservableObject {
    
    private let movieDataSource: MovieDataSource
    
    @Published var popularMoviesList: [MovieModel] = []
    @Published var freeMoviesList: [MovieModel] = []
    @Published var trendingMoviesList: [MovieModel] = []
    
    init(movieDataSource: MovieDataSource) {
        self.movieDataSource = movieDataSource
        
        Task {
            await fetchPopularMovies()
            await fetchFreeMovies()
            await fetchTrendingMovies()
        }
    }
    
    func fetchPopularMovies() async {
        do {
            popularMoviesList = try await movieDataSource.fetchPopularMovies()
        } catch {
            print("Error fetching popular movies: \(error)")
        }
    }
    
    func fetchFreeMovies() async {
        do {
            freeMoviesList = try await movieDataSource.fetchFreeMovies()
        } catch {
            print("Error fetching free movies: \(error)")
        }
    }
    
    func fetchTrendingMovies() async {
        do {
            trendingMoviesList = try await movieDataSource.fetchTrendingMovies()
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
}
