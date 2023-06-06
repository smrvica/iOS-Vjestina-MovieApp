//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by endava-bootcamp on 21.05.2023..
//

import Foundation
import MovieAppData

class MovieDataSource {
    
    private let baseURL = "https://five-ios-api.herokuapp.com"
    private let userDefaults = UserDefaults.standard
    
    func fetchFreeMovies(criteria: MovieTagModel, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        let urlString = baseURL + "/api/v1/movie/free-to-watch?criteria=" + criteria.rawValue
        return fetchMovies(criteria: criteria, urlString: urlString, completion: completion)
    }
    
    func fetchPopularMovies(criteria: MovieTagModel, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        let urlString = baseURL + "/api/v1/movie/popular?criteria=" + criteria.rawValue
        return fetchMovies(criteria: criteria, urlString: urlString, completion: completion)
    }
    
    func fetchTrendingMovies(criteria: MovieTagModel, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        let urlString = baseURL + "/api/v1/movie/trending?criteria=" + criteria.rawValue
        return fetchMovies(criteria: criteria, urlString: urlString, completion: completion)
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Result<MovieDetailsModel, Error>) -> Void) {
        let urlString = "\(baseURL)/api/v1/movie/\(id)/details"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "Data Error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(MovieDetailsModel.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchBaseMovie(id: Int, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        
        let urlString = "\(baseURL)/api/v1/movie/\(id)"
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "Data Error", code: 0)
                completion(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(MovieModel.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovies(criteria: MovieTagModel, urlString: String,completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "Data Error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode([MovieModel].self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func setFavorites(favorites: [Int]) {
        userDefaults.set(favorites, forKey: "favorite")
        print("Help")
        print(favorites)
    }
    
    func getFavorites() -> [Int] {
        return userDefaults.array(forKey: "favorite") as? [Int] ?? []
    }
    
    func changeFavoriteStatus(id : Int) {
        var favoritesList = getFavorites()
        
        if favoritesList.contains(where: { $0 == id}) {
            favoritesList.removeAll(where: { $0 == id})
        } else {
            favoritesList.append(id)
        }
        setFavorites(favorites: favoritesList)
    }
}

struct MovieModel: Decodable {

    let id: Int
    let name: String
    let year: Int
    let summary: String
    let imageUrl: String

}

enum MovieTagModel: String, Decodable {

    case streaming = "STREAMING"
    case onTv = "ON_TV"
    case forRent = "FOR_RENT"
    case inTheaters = "IN_THEATERS"
    case movie = "MOVIE"
    case tvShow = "TV_SHOW"
    case trendingToday = "TODAY"
    case trendingThisWeek = "THIS_WEEK"

}

struct MovieDetailsModel: Decodable {

    let id: Int
    let name: String
    let year: Int
    let releaseDate: String
    let duration: Int
    let rating: Double
    let summary: String
    let imageUrl: String
    let categories: [MovieCategoryModel]
    let crewMembers: [MovieCrewMemberModel]

}

struct MovieCrewMemberModel: Decodable {
    
    let name: String
    let role: String

}

enum MovieCategoryModel: String, Decodable {

    case action = "ACTION"
    case adventure = "ADVENTURE"
    case comedy = "COMEDY"
    case crime = "CRIME"
    case drama = "DRAMA"
    case fantasy = "FANTASY"
    case romance = "ROMANCE"
    case scienceFiction = "SCIENCE_FICTION"
    case thriller = "THRILLER"
    case western = "WESTERN"

}
