import UIKit

class Popular: NSObject, Decodable{

    //MARK: Property
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movie: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movie = "results"
    }
    
    //MARK: Init
    init(page: Int, total_results: Int, total_pages: Int, movie: [Movie]) {
        self.page = page
        self.totalResults = total_results
        self.totalPages = total_pages
        self.movie = movie
    }
    
    //MARK: Methods
    class func converterJSON(_ json: [String: Any]) -> Data?{
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    class func decodableMovie(_ jsonData: Data) -> Popular?{
        do {
            return try JSONDecoder().decode(Popular.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
