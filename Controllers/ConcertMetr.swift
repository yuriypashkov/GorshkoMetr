
import UIKit


class ConcertMetr: UIViewController {
    
    let transition = SlideInTransition()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var str = "концертов"
    
    var count = 0 {
        didSet {
            defaults.set(count, forKey: "countKey")
            
            let temp = (count + 10) % 10
            switch temp {
            case 0:
                str = "концертов"
            case 1:
                str = "концерт"
            case 2,3,4:
                str = "концерта"
            default:
                str = "концертов"
            }
            
            if count == 11 || count == 12 || count == 13 || count == 14 {
                str = "концертов"
            }
            
            countLabel.text = "\(count) \(str)"
            if count < 0 {
                count = 0
                countLabel.text = "0 концертов"
            }
        }
    }
    let defaults = UserDefaults.standard
    
    
    @IBOutlet var labelsStackView: [UILabel]!
    
    @IBAction func menuButtonTap(_ sender: UIButton) {
            guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "NewMenuViewController") else { return }
            menuViewController.modalPresentationStyle = .overCurrentContext
            menuViewController.transitioningDelegate = self
            present(menuViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func tapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var buttonPlusHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonPlusWidthConstraint: NSLayoutConstraint!
    
    @IBAction func buttonPlusTap(_ sender: UIButton) {
        count += 1
    }
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // уменьшим высоту стеквью с лейблами для iphone se 1st gen
        if UIScreen.main.bounds.height < 667 {
            for label in labelsStackView {
                label.font = UIFont(name: "CyrillicOldEditedbyme-Bold", size: 30)
            }
            buttonPlusWidthConstraint.constant = 70
            buttonPlusHeightConstraint.constant = 70
        }
    
        // get
        count = defaults.integer(forKey: "countKey")
        
    }

}

extension ConcertMetr: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

