
import UIKit
import SpriteKit

enum MenuType: Int {
    case home
    case concertCounter
    case test
    case game
    case achivements
}

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) {
            //print("Dismiss \(menuType)")
        }
        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController else { return}
        switch menuType {
        case .concertCounter:
            guard let concertViewController = storyboard?.instantiateViewController(withIdentifier: "ConcertMetr") else {return}
            if #available(iOS 13, *) { concertViewController.modalPresentationStyle = .fullScreen }
            //concertViewController.modalTransitionStyle = .crossDissolve
            topViewController.present(concertViewController, animated: true, completion: nil)
        case .test:
            guard let quizViewController = storyboard?.instantiateViewController(withIdentifier: "NewQuizViewController") else {return}
            if #available(iOS 13, *) { quizViewController.modalPresentationStyle = .fullScreen }
            topViewController.present(quizViewController, animated: true, completion: nil)
        case .game:
            //print("Game button touch")
            guard let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") else {return}
            if #available(iOS 13, *) { gameViewController.modalPresentationStyle = .fullScreen }
            topViewController.present(gameViewController, animated: true, completion: nil)
        case .achivements:
            guard let achivementsViewController = storyboard?.instantiateViewController(withIdentifier: "AchivementsViewController") else { return}
            if #available(iOS 13, *) { achivementsViewController.modalPresentationStyle = .fullScreen }
            topViewController.present(achivementsViewController, animated: true, completion: nil)
        default:
            return
        }
    }
    

}

