

import UIKit

class ConcertChoiceModel {
    
    var arrayOfConcerts: [Concert] = [
        Concert(key: "concert1", name: "клуб Спартак \n 1999 год"),
        Concert(key: "concert2", name: "СК Олимпийский \n 2003 год"),
        Concert(key: "concert3", name: "\"На краю\" \n 2013 год"),
        Concert(key: "concert4", name: "Мёртвый анархист \n 2002 год"),
        Concert(key: "concert5", name: "Проказник Скоморох \n 1997 год"),
        Concert(key: "concert6", name: "НАШЕСТВИЕ \n 2013 год"),
        Concert(key: "concert7", name: "Окна Открой \n 2005 год"),
        Concert(key: "concert8", name: "КиШ в Киеве \n 2002 год"),
        Concert(key: "concert9", name: "Чартова Дюжина \n 2010 год"),
        Concert(key: "other", name: "Что-то другое")
    ]
        
}


class ConcertMetrModel {
    
    var concertCount: Int?
    weak var delegate: ConcertCountDelegate?
    let defaults = UserDefaults.standard
    
    func initModel() {
        concertCount = defaults.integer(forKey: "countKey")
        delegate?.updateLabel()
    }
    
    func countUP() {
        concertCount = defaults.integer(forKey: "countKey")
        concertCount! += 1
        defaults.set(concertCount, forKey: "countKey")
        delegate?.updateLabel()
    }
    
}
