import UIKit

class Genre: NSObject, Decodable {
    
    //MARK: Property
    let id: Int
    let name: String
    
    //MARK: Init
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    //MARK: Methods
    class func converterJSON(_ json: [[String: Any]]) -> Data?{
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    class func decodableGenres(_ jsonData: Data) -> [Genre]?{
        do {
            return try JSONDecoder().decode([Genre].self, from: jsonData)
        } catch {
            print(error.localizedDescription )
            return nil
        }
    }
}
