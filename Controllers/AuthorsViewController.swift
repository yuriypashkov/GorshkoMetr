import UIKit

class AuthorsViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if let url = URL(string: "https://vk.com/id50526093"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case 1:
            if let url = URL(string: "https://www.instagram.com/dzegn/"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case 2:
            if let url = URL(string: "https://www.instagram.com/misserchmitt/"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        default:
            return
        }
    }
    
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) { closeButton.isHidden = true }
        if UIScreen.main.bounds.height < 896 {
            bottomConstraint.constant = 20
        }
    }
    
}
