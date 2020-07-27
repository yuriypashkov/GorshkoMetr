

import UIKit

class Achivement {
    
    var imageName: String
    var title: String
    var message: String
    var isAchived: Bool
    
    
    init(imageName: String, title: String, message: String, isAchived: Bool) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.isAchived = isAchived
    }
}
