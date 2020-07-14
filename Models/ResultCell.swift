import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    
    func setData(data: Answer, number: Int) {
        questionNumberLabel.text = "Вопрос №\(number)"
        questionTextLabel.text = data.question
        userAnswerLabel.text = data.userAnswer
        correctAnswerLabel.text = data.correctAnswer
        if data.correctAnswer == data.userAnswer {
            userAnswerLabel.textColor = .systemGreen
        } else {
            userAnswerLabel.textColor = .systemRed
        }
    }

}
