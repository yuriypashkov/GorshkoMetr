

import Foundation
import UIKit

class CustomAlert: UIView {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var achievementImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    func set(title: String, message: String, imageName: String) {
        titleLabel.text = title
        messageLabel.text = message
        achievementImage.image = UIImage(named: imageName)
    }
    
}
