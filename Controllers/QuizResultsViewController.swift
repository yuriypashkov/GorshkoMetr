
import UIKit

class QuizResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func buttonCloseClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBOutlet weak var buttonClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonClose.layer.cornerRadius = buttonClose.frame.width / 2
        if #available(iOS 13, *) { buttonClose.isHidden = true }
        
        tableView.backgroundColor = .clear
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
}

extension QuizResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerBank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = answerBank[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultCell
        cell.setData(data: data, number: indexPath.row + 1)
        cell.backgroundColor = .clear
        return cell
    }
    
}
