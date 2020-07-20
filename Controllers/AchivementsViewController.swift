
import UIKit

class AchivementsViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var concertsCount: UILabel!
    @IBOutlet weak var scoreCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        concertsCount.text = defaults.string(forKey: "countKey")
        scoreCount.text = defaults.string(forKey: "scoreKey")
    }

    
}
