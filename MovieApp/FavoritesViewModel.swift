
import Foundation

class FavoritesViewModel: ObservableObject {
    
    private let dataSource: MovieDataSource
    
    @Published var favorites: [MovieModel] = []
    
    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
        Task {
            await fetchFavoriteMovies()
        }
    }
    
    private func fetchFavoriteMovies() async {
        let favoritesList = dataSource.getFavorites()
        var movies = favorites.filter({
            let movie = $0
            return favoritesList.contains(where: {$0 == movie.id})
        })
        let diff = favoritesList.filter({
            let id = $0
            return !movies.contains(where: {id == $0.id})
        })
        print(diff)
        for i in diff {
            do {
                let movieModel = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MovieModel, Error>) in
                    dataSource.fetchBaseMovie(id: i) { result in
                        switch result {
                        case .success(let movieModel):
                            continuation.resume(returning: movieModel)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
                movies.append(movieModel)
            } catch {
                print("Error fetching favorites: \(error)")
            }
        }
        favorites = movies
    }
    
    func changeFavorite(id: Int) {
        dataSource.changeFavoriteStatus(id: id)
        Task {
            await fetchFavoriteMovies()
        }
    }
}
