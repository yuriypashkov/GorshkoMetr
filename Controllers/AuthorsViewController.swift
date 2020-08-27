import UIKit

class AuthorsViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) { closeButton.isHidden = true }
            
    }
    
}
