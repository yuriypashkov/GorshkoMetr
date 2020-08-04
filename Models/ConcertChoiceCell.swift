

import UIKit

protocol CellProtocolDelegate: class {
    func dismissController()
}

class ConcertChoiceCell: UITableViewCell {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var concertCountLabel: UILabel!
    
    @IBOutlet weak var concertButton: UIButton!
    
    var classConcertKey: String?
    
    func setData(concertKey: String, concertName: String) {
        concertButton.setTitle(concertName, for: .normal)
        concertButton.titleLabel?.textAlignment = .center
        let concertCount = defaults.integer(forKey: concertKey)
        concertCountLabel.text = String(concertCount)
        
        // сохраним текущее значение concertKey для установки в defaults
        classConcertKey = concertKey
    }
    
    weak var delegate: CellProtocolDelegate?
    
    @IBAction func buttonTap(_ sender: UIButton) {
        delegate?.dismissController()
        var currentConcertCount = defaults.integer(forKey: classConcertKey!)
        currentConcertCount += 1
        defaults.set(currentConcertCount, forKey: classConcertKey!)
        
        concertMetrModel.countUP()

    }
    
    
}
