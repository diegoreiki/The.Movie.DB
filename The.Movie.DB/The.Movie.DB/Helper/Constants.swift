import Foundation

struct Constants {
    
    static let language = "pt-BR"
    static var base_url = "https://api.themoviedb.org/3"
    static var base_image_url = "https://image.tmdb.org/t/p"
    
    static let keyAPI = "1ef843b5947ca54b9ba168f23d3788d3"
    static let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZWY4NDNiNTk0N2NhNTRiOWJhMTY4ZjIzZDM3ODhkMyIsInN1YiI6IjVjNjk2ZGRkMGUwYTI2MmZhMWEwMzc1MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dmDmSRuOnC7SBuO6JRxdLWIAsBWIqEx8pXeTRNTOY2s"
    
    enum url {
        static var genre = "/genre/movie/list"
        static var popular = "/movie/popular"
    }
    
    enum title {
        static var error = "Erro"
        static var warning = "Atenção"
    }
    
    enum message {
        static var error = "Ocorreu um error desconhecido"
        static var errorGenresSelected = "Houve um erro ao buscar os filmes por categoria selecionada"
        static var errorPopularmovies = "Houve um erro ao buscar os filmes populares"
    }
}
