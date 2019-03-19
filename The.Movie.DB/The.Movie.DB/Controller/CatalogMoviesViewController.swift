import UIKit

class CatalogMoviesViewController: UIViewController {
    
    //MARK: Property
    var genres = [Genre]()
    var movies = [Movie]()
    var page = 1
    
    @IBOutlet weak var labelGenreMovie: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGenres()
        getPopularMovies(page: self.page)
        setLogoInNavigationBar()
    }
    
    //MARK: Methods
    func getPopularMovies(page: Int){
        loading.startAnimating()
        
        MoviesApi().requestPopularMovies(page: page, returnPopular: { (popular) in
            self.loading.stopAnimating()
            
            guard let responsePopular = popular else {
                Alert(controller: self).show(title: Constants.title.error, message: Constants.message.errorPopularmovies, titleButtonAction: "Ok", titleButtonCancel: nil, completion: nil)
                return
            }
            self.page = responsePopular.page
            self.movies = responsePopular.movie
            self.labelGenreMovie.text = "Filmes mais populares"
            
            self.collectionViewMovies.reloadData()
        }) { (error) in
            Alert(controller: self).show(title: Constants.title.error, message: Constants.message.errorPopularmovies, titleButtonAction: "Ok", titleButtonCancel: nil, completion: nil)
        }
    }
    
    func getGenreMovies(id: Int){
        loading.startAnimating()
        
        MoviesApi().requestGenreMovies(id: id, returnMovies: { (movies) in
            self.loading.stopAnimating()
            
            guard let responseMovies = movies else {
                Alert(controller: self).show(title: Constants.title.error, message: Constants.message.errorGenresSelected, titleButtonAction: "Ok", titleButtonCancel: nil, completion: nil)
                return
            }
            self.movies = responseMovies
            
            self.collectionViewMovies.reloadData()
        }) { (error) in
            Alert(controller: self).show(title: Constants.title.error, message: Constants.message.errorGenresSelected, titleButtonAction: "Ok", titleButtonCancel: nil, completion: nil)
        }
    }
    
    func setupGenres(){
        loading.startAnimating()
        
        GenresApi().requestGenres(returnGenres: { (genres) in
            self.loading.stopAnimating()
            self.genres = genres
        }) { (error) in
            Alert(controller: self).show(title: Constants.title.error, message: Constants.message.errorGenresSelected, titleButtonAction: "Ok", titleButtonCancel: nil, completion: nil)
        }
    }
    
    //MARK: Actions
    @IBAction func buttonItemGenre(_ sender: Any) {
        let view = storyboard?.instantiateViewController(withIdentifier: "genreViewController") as! GenreViewController
        
        if let navigation = self.navigationController{
            self.movies.removeAll()
            
            view.genres = self.genres
            view.chooseGenreDelegate = self
            navigation.pushViewController(view, animated: true)
        }
    }
}

//MARK: ChooseGenreDelegate
extension CatalogMoviesViewController: ChooseGenreDelegate{
    func chooseGenre(id: Int, title: String) {
        getGenreMovies(id: id)
        
        self.labelGenreMovie.text = title
        collectionViewMovies.reloadData()
    }
}

//MARK: UICollectionView
extension CatalogMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular_cell", for: indexPath) as! PopularMoviesCollectionViewCell
        
        if let imageData = converterImage(url: Constants.base_image_url + "/w342" + movies[indexPath.row].posterPath){
            cell.imageMovie.image = UIImage(data: imageData)
            cell.imageMovie.layer.masksToBounds = true
            cell.imageMovie.contentMode = .scaleAspectFill
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = storyboard?.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsMovieViewController
        if let navigation = navigationController{
            view.movie = movies[indexPath.row]
            navigation.pushViewController(view, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width/3.2;
        let itemHeight = itemWidth;
        
        return CGSize(width: itemWidth, height: itemHeight);
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let lastCell = movies.count - 1
//        
//        if indexPath.row == lastCell {
//            self.getPopularMovies(page: self.page + 1)
//        }
//    }
}

