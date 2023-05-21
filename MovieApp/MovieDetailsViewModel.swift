//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by endava-bootcamp on 21.05.2023..
//

import Foundation
import MovieAppData

class MovieDetailsViewModel: ObservableObject {
    
    private let movieDataSource: MovieDataSource
    
    @Published var movieDetails: MovieDetailsModel? = nil
    
    init(movieDataSource: MovieDataSource, id: Int) {
        self.movieDataSource = movieDataSource
        
        Task {
            await fetchMovieDetails(id: id)
        }
    }
    
    func fetchMovieDetails(id: Int) async {
        do {
            movieDetails = try await movieDataSource.fetchMovieDetails(id: id)
        } catch {
            print("Error fetching movie details \(error)")
        }
    }
}
