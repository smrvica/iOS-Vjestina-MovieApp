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
    private let freeTags = [MovieTagModel.movie, MovieTagModel.tvShow]
    private let trendingTags = [MovieTagModel.trendingThisWeek, MovieTagModel.trendingToday]
    private let popularTags = [MovieTagModel.forRent, MovieTagModel.inTheaters, MovieTagModel.onTv, MovieTagModel.streaming]
    
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
        var movies: [MovieModel] = []
        for tag: MovieTagModel in popularTags {
            do {
                let movieModels = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[MovieModel], Error>) in
                    movieDataSource.fetchPopularMovies (criteria: tag) { result in
                        switch result {
                        case .success(let movieModels):
                            continuation.resume(returning: movieModels)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
                movies.append(contentsOf: movieModels)
            } catch {
                print("Error fetching popular movies: \(error)")
            }
        }
        self.popularMoviesList = movies
    }
    
    func fetchFreeMovies() async {
        var movies: [MovieModel] = []
        for tag: MovieTagModel in freeTags {
            do {
                let movieModels = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[MovieModel], Error>) in
                    movieDataSource.fetchFreeMovies (criteria: tag) { result in
                        switch result {
                        case .success(let movieModels):
                            continuation.resume(returning: movieModels)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
                movies.append(contentsOf: movieModels)
            } catch {
                print("Error fetching freeToWatch movies: \(error)")
            }
        }
        self.freeMoviesList = movies
    }
    
    func fetchTrendingMovies() async {
        var movies: [MovieModel] = []
        for tag: MovieTagModel in trendingTags {
            do {
                let movieModels = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[MovieModel], Error>) in
                    movieDataSource.fetchTrendingMovies (criteria: tag) { result in
                        switch result {
                        case .success(let movieModels):
                            continuation.resume(returning: movieModels)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
                movies.append(contentsOf: movieModels)
            } catch {
                print("Error fetching trending movies: \(error)")
            }
        }
        self.trendingMoviesList = movies
    }
}
