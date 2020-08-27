
import UIKit
import Foundation

class AchivementView: UIView {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var okButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    func set(title: String, message: String, imageName: String) {
        titleLabel.text = title
        messageLabel.text = message
        image.image = UIImage(named: imageName)
    }
    
}
