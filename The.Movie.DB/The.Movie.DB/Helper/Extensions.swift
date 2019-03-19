import Foundation
import UIKit

extension UIViewController{
    
    func setLogoInNavigationBar() {
        let logo = UIImageView(image: UIImage(named: "LogoHorizontal"));
        logo.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 76, height: 30));
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: 76, height: 30));
        viewTitle.addSubview(logo);
        
        self.navigationItem.titleView = viewTitle;
    }
    
    func converterImage(url: String) -> Data?{
        let imageUrl = URL(string: url)
        let imageData = NSData(contentsOf: imageUrl!)
        return imageData as Data?
    }
}
