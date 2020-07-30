
import UIKit

class AchivementsViewController: UIViewController {
    
    override var shouldAutorotate: Bool {
         return false
     }
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var concertsCount: UILabel!
    @IBOutlet weak var scoreCount: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var quizPassedLabel: UILabel!
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var launchCountLabel: UILabel!
    @IBOutlet weak var itemsLostLabel: UILabel!
    @IBOutlet weak var trashItemsLabel: UILabel!
    
    @IBOutlet weak var firstLineImages: UIStackView!
    
    
    @IBOutlet var achivementButtons: [UIButton]!
    
    @IBAction func achivmentButtonClick(_ sender: UIButton) {
        let achivement = achivementsArray[sender.tag]
        setAlert(imageName: achivement.imageName, title: achivement.title, message: achivement.message)
        animateIn()
    }
    
    var achivementsArray: [Achivement] = [
        Achivement(imageName: "bat", title: "КонцертМастер", message: "Ты невероятно хорош, ибо посмотрел концерты КиШа 10 или более раз", isAchived: false),
        Achivement(imageName: "skull", title: "Черепность", message: "Я нахер что сюда писать, придумаем потом", isAchived: false),
        Achivement(imageName: "zombie", title: "Зомбийность", message: "Да, потом придумаем", isAchived: false)
    ]

    
    private var alertView: CustomAlert!
    
    let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set buttons height
        if UIScreen.main.bounds.height < 667 {
            if let height = (firstLineImages.constraints.filter { $0.firstAttribute == .height}).first {
                height.constant = 80
            }
        }
        
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        let countKey = defaults.integer(forKey: "countKey")
        concertsCount.text = String(countKey)
        let scoreKey = defaults.integer(forKey: "scoreKey")
        scoreCount.text = String(scoreKey)
        let correctAnswers = defaults.integer(forKey: "correctAnswers")
        correctAnswersLabel.text = String(correctAnswers)
        let quizPassed = defaults.integer(forKey: "quizPassed")
        quizPassedLabel.text = String(quizPassed)
        if defaults.integer(forKey: "answersCount") != 0 {
            let answersCount = defaults.double(forKey: "answersCount")
            let percent: Double = (Double(correctAnswers) / answersCount) * 100
            answersCountLabel.text = String(format: "%.0f", percent)
        }
        launchCountLabel.text = defaults.string(forKey: "launchCount")
        let itemsLost = defaults.integer(forKey: "itemsLost")
        itemsLostLabel.text = String(itemsLost)
        let trashItems = defaults.integer(forKey: "trashItems")
        trashItemsLabel.text = String(trashItems)
        
        //setup blur
        setupVisualEffectView()
        
        //setup achivements
        if countKey >= 10 {
            achivementsArray[0].isAchived = true
        }
        
        //setup achived buttons
        for button in achivementButtons {
            let achivement = achivementsArray[button.tag]
            if achivement.isAchived {
                button.isEnabled = true
            }
        }

    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func animateIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    func setAlert(imageName: String, title: String, message: String) {
        alertView = Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)?.first as? CustomAlert
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        alertView.set(title: title, message: message, imageName: imageName)
    }
    
    
    @objc func okButtonPressed() {
        UIView.transition(with: self.view, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.alertView.removeFromSuperview()
        }, completion: nil)
        visualEffectView.alpha = 0
    }
    
}
