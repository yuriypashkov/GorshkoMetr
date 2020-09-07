import UIKit

class AuthorsViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var prodLabel: UILabel!
    @IBOutlet weak var artLabel: UILabel!
    @IBOutlet weak var progLabel: UILabel!
    @IBOutlet weak var musLabel: UILabel!
    
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if let url = URL(string: "https://github.com/yuriypashkov/"), UIApplication.shared.canOpenURL(url) {
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
        case 3:
            if let url = URL(string: "https://www.instagram.com/krll.wav/"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        default:
            return
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) { closeButton.isHidden = true }
        if UIScreen.main.bounds.height < 896 {
            //bottomConstraint.constant = 20
            stackViewLeading.constant = 40
            stackViewTrailing.constant = 35
            
        }
        progLabel.text = """
        ЮРЕЦ
        идеи, программист
        """
        artLabel.text = """
        МАКС
        художник
        """
        prodLabel.text = """
        СТЕПАН
        идеи, продюсер
        """
        
        musLabel.text = """
        КИРИЛЛ
        музыка в игре
        """
        
    }
    
}
