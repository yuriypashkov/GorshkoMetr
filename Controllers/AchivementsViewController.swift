
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
        let achivement = achivementBank.achivementsArray[sender.tag]
        if achivement.isAchived {
            setAlert(imageName: achivement.imageName, title: achivement.title, message: achivement.message, isHiddenShareButton: false)
        } else {
            setAlert(imageName: achivement.imageName + "_Black", title: achivement.title, message: achivement.message, isHiddenShareButton: true)
        }
        animateIn()
    }
    
    var achivementBank = AchivementBank()

    
    private var alertView: AchivementView!
    
    let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set buttons height
//        if UIScreen.main.bounds.height < 667 {
//            if let height = (firstLineImages.constraints.filter { $0.firstAttribute == .height}).first {
//                height.constant = 80
//            }
//        }
        
        closeButton.layer.cornerRadius = closeButton.frame.width / 2

        concertsCount.text = String(achivementBank.countKey)
        scoreCount.text = String(achivementBank.scoreKey)
        correctAnswersLabel.text = String(achivementBank.correctAnswers)
        quizPassedLabel.text = String(achivementBank.quizPassed)
        answersCountLabel.text = String(format: "%.0f", achivementBank.percent)
        launchCountLabel.text = String(achivementBank.launchCount)
        itemsLostLabel.text = String(achivementBank.itemsLost)
        trashItemsLabel.text = String(achivementBank.trashItems)
        
        //setup blur
        setupVisualEffectView()
    
        //setup achived buttons
        for button in achivementButtons {
            let achivement = achivementBank.achivementsArray[button.tag]
            if achivement.isAchived {
                button.isEnabled = true
                let imageName = String(button.tag) + "_Color"
                button.setImage(UIImage(named: imageName), for: .normal)
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
    
    func setAlert(imageName: String, title: String, message: String, isHiddenShareButton: Bool) {
        alertView = Bundle.main.loadNibNamed("AchivementView", owner: self, options: nil)?.first as? AchivementView
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        alertView.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        alertView.set(title: title, message: message, imageName: imageName, isHiddenShareButton: isHiddenShareButton )
    }
    
    @objc func shareButtonPressed() {
        let message = "Я получил новую ачивку \"\(String(describing: alertView.titleLabel.text!))\", в приложении Горшкометр.  Совершённое действо: \"\(String(describing: alertView.messageLabel.text!))\". Ссылка на приложение: https://apps.apple.com/ru/app/id1517319081"
        let vc = UIActivityViewController(activityItems: [alertView.image.image!, message], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc func okButtonPressed() {
        UIView.transition(with: self.view, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.alertView.removeFromSuperview()
        }, completion: nil)
        visualEffectView.alpha = 0
    }
    
}
