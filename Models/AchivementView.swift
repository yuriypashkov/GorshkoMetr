
import UIKit
import Foundation

class AchivementView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var notShareLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    func set(title: String, message: String, imageName: String, isHiddenShareButton: Bool) {
        titleLabel.text = title
        messageLabel.text = message
        image.image = UIImage(named: imageName)
        shareButton.isHidden = isHiddenShareButton
        notShareLabel.isHidden = !isHiddenShareButton
        notShareLabel.transform = CGAffineTransform(rotationAngle: .pi / 4)
        if isHiddenShareButton {
            backgroundImage.image = UIImage(named: "achivementBackgroundTransparentBlack")
        }
    }
    
}
