import UIKit

class DetailsMovieViewController: UIViewController {
    
    //MARK: Property
    var movie: Movie?
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDateRelease: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetails()
    }
    
    //MARK: Methods
    func setupDetails(){
        
        if let detailsMovie = movie{
            
            let stringImageBackdrop = detailsMovie.backdropPath
            let stringImagePoster = detailsMovie.posterPath
            
            if let imageData = converterImage(url: Constants.base_image_url + "/w780/" + stringImageBackdrop){
                imageBack.image = UIImage(data: imageData)
                imageBack.layer.masksToBounds = true
                imageBack.contentMode = .scaleAspectFill
            }
            
            if let imageData = converterImage(url: Constants.base_image_url + "/w342/" + stringImagePoster){
                imagePoster.image = UIImage(data: imageData)
                imagePoster.clipsToBounds = false
                imagePoster.layer.masksToBounds = true
                imagePoster.contentMode = .scaleAspectFill
            }
            
            let stringDate = detailsMovie.releaseDate
            labelDateRelease.text = String(stringDate.prefix(4))
            labelTitle.text = detailsMovie.title
            labelOverview.text = detailsMovie.overview
        }
    }
}
