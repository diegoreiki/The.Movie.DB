import UIKit
import Alamofire

class GenresApi: NSObject {
    
    func requestGenres(returnGenres: @escaping ((_ genres: [Genre]) -> Void), occurredError: ((_ error: NSError?) -> Void)?){
        
        let url = Constants.base_url + Constants.url.genre + "?language=" + Constants.language + "&api_key=" + Constants.keyAPI
        
        Alamofire.request(url, method: .get, parameters: nil).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
                if let JSON = response.value as? [String: Any]{
                    
                    guard let genresJSON = JSON["genres"] as? [[String: Any]] else { return }
                    guard let jsonData = Genre.converterJSON(genresJSON) else { return }
                    guard let genres = Genre.decodableGenres(jsonData) else { return }
                    
                    returnGenres(genres)
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
