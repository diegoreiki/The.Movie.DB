import UIKit

class Alert: NSObject {
    
    //MARK: Init
    let controller: UIViewController?
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    //MARK: Methods
    func show(title: String, message: String, titleButtonAction: String, titleButtonCancel: String?, completion: (() -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if (titleButtonCancel != nil){
            let buttonAction = UIAlertAction(title: titleButtonCancel, style: .destructive, handler: nil);
            alert.addAction(buttonAction)
        }
        let buttonAction = UIAlertAction(title: titleButtonAction, style: .default) { (action) in
            if completion != nil{
                completion!()
            }
        }
        alert.addAction(buttonAction)
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
