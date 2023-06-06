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
    private let favoritesViewModel: FavoritesViewModel
    private let id: Int
    
    @Published var movieDetails: MovieDetailsModel? = nil
    @Published var favorite: Bool = false
    
    init(movieDataSource: MovieDataSource, id: Int, favViewModel: FavoritesViewModel) {
        self.movieDataSource = movieDataSource
        favoritesViewModel = favViewModel
        self.id = id
        
        Task {
            await fetchMovieDetails()
        }
    }
    
    func fetchMovieDetails() async {
        do {
            let movieDetailsModel = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MovieDetailsModel, Error>) in
                movieDataSource.fetchMovieDetails(id: id) { result in
                    switch result {
                    case .success(let movieDetailsModel):
                        continuation.resume(returning: movieDetailsModel)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            self.movieDetails = movieDetailsModel
            let favorites = movieDataSource.getFavorites()
            if favorites.contains(where: {$0 == movieDetailsModel.id}) {
                favorite = true
            } else {
                favorite = false
            }
        } catch {
            print("Error fetching movie details: \(error)")
        }
    }
    
    func changeFavorite() {
        favoritesViewModel.changeFavorite(id: id)
        favorite = !favorite
    }
}
