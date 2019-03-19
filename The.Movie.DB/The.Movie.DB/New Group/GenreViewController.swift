import UIKit

protocol ChooseGenreDelegate {
    func chooseGenre(id: Int, title: String)
}

class GenreViewController: UIViewController {
    
    var genres = [Genre]()
    var idGenreSelected: Int?
    var titleGenreSelected: String?
    var chooseGenreDelegate: ChooseGenreDelegate!
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    @objc func setGenre(){
        guard let id = idGenreSelected else { return }
        guard let title = titleGenreSelected else { return }
        
        chooseGenreDelegate.chooseGenre(id: id, title: title)
        
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }
    
    func setButtonItemOk(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(setGenre))
    }
}

//MARK: UITableView
extension GenreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundView?.backgroundColor = UIColor.blue
        cell.textLabel?.text = genres[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        setButtonItemOk()
        idGenreSelected = genres[indexPath.row].id
        titleGenreSelected = genres[indexPath.row].name
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
