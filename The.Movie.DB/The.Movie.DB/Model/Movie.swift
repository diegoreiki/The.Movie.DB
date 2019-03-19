import UIKit

class Movie: NSObject, Decodable {
    
    //MARK: Property
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let genreIds: [Int]
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
    
    //MARK: Init
    init(id: Int, title: String, overview: String, posterPath: String, backdropPath: String, genreIds: [Int], releaseDate: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.releaseDate = releaseDate
    }
    
    //MARK: Methods
    class func converterJSON(_ json: [[String: Any]]?) -> Data?{
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    class func decodableMovie(_ jsonData: Data) -> [Movie]?{
        do {
            return try JSONDecoder().decode([Movie].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
