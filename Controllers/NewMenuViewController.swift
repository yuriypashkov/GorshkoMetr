
import UIKit

class NewMenuViewController: UIViewController {

    @IBAction func closeButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var closeButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var closeButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonsMenuHeight: NSLayoutConstraint!
    @IBOutlet weak var menuArt: UIImageView!
    
    let topViewController = UIApplication.shared.keyWindow?.rootViewController
    
    func openVC(vcName: String) {
        dismiss(animated: true, completion: nil)
        guard let quizViewController = storyboard?.instantiateViewController(withIdentifier: vcName) else {return}
        if #available(iOS 13, *) { quizViewController.modalPresentationStyle = .fullScreen }
        topViewController!.present(quizViewController, animated: true, completion: nil)
    }
    
    @IBAction func quizButtonTap(_ sender: UIButton) {
        openVC(vcName: "NewQuizViewController")
    }
    
    @IBAction func achivementsButtonTap(_ sender: UIButton) {
        openVC(vcName: "AchivementsViewController")
    }
    
    @IBAction func concertsButtonTap(_ sender: UIButton) {
        openVC(vcName: "ConcertMetr")
    }
    
    @IBAction func gameButtonTap(_ sender: UIButton) {
        openVC(vcName: "GameViewController")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // уменьшаем  элементы меню для  SE первого поколения
        if UIScreen.main.bounds.height < 667 {
            // уменьшаем кнопку закрытия меню
            closeButtonWidth.constant = 110
            closeButtonHeight.constant = 40
            // уменьшаем высоту стека с кнопками
            buttonsMenuHeight.constant = 250
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTap(_:)))
        menuArt.isUserInteractionEnabled = true
        menuArt.addGestureRecognizer(tapGestureRecognizer)
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.imageTap(_:)))
        swipeGestureRecognizer.direction = .left
        menuArt.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    @objc func imageTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
