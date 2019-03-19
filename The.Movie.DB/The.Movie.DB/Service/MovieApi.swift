import UIKit
import Alamofire

class MoviesApi: NSObject {
    
    func requestPopularMovies(page: Int, returnPopular: @escaping ((_ popular: Popular?) -> Void), occurredError: ((_ error: NSError?) -> Void)?) {
        
        let url = Constants.base_url + Constants.url.popular + "?language=" + Constants.language + "&api_key=" + Constants.keyAPI + "&page=" + String(page)
        Alamofire.request(url, method: .get, parameters: nil).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
                if let JSON = response.value as? [String: Any]{
                    
                    guard let jsonData = Popular.converterJSON(JSON) else { return }
                    let popular = Popular.decodableMovie(jsonData)

                    returnPopular(popular)
                    
                }
            case .failure(let error):
                if occurredError != nil {
                    occurredError!(error as NSError)
                }
                break
            }
        }
    }
    
    func requestGenreMovies(id: Int, returnMovies: @escaping ((_ movies: Array<Movie>?) -> Void), occurredError: ((_ error: NSError?) -> Void)?) {
        
        let url = Constants.base_url + "/genre/\(id)/movies" + "?language=" + Constants.language + "&api_key=" + Constants.keyAPI
        Alamofire.request(url, method: .get, parameters: nil).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
                if let JSON = response.value as? [String: Any]{
                    
                    guard let moviesJSON = JSON["results"] as? [[String: Any]] else { return }
                    guard let jsonData = Movie.converterJSON(moviesJSON) else { return }
                    let movies = Movie.decodableMovie(jsonData)
                    
                    returnMovies(movies)
                }
            case .failure(let error):
                if occurredError != nil {
                    occurredError!(error as NSError)
                }
                break
            }
        }
    }
}

