
import UIKit

class ConcertChoiceViewController: UIViewController, CellProtocolDelegate {
    
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    var concerts = ConcertChoiceModel()

    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeading: NSLayoutConstraint!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                if UIScreen.main.bounds.height < 667 {
                    tableViewTrailing.constant = 50
                    tableViewLeading.constant = 40
                    tableViewTop.constant = 105
                } else if UIScreen.main.bounds.height < 895 {
                    tableViewTop.constant = 130
        }
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.imageSwipe(_:)))
        swipeGestureRecognizer.direction = .down
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(swipeGestureRecognizer)
        
        tableView.backgroundColor = .clear
    }
    
    @objc func imageSwipe(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension ConcertChoiceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concerts.arrayOfConcerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = concerts.arrayOfConcerts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConcertChoiceCell") as! ConcertChoiceCell
        cell.backgroundColor = .clear
        cell.delegate = self
        cell.setData(concertKey: data.key, concertName: data.name)
        return cell
    }
    
    
}
