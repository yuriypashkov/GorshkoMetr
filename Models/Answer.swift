
import Foundation

class Answer {
    
    let question: String
    let correctAnswer: String
    let userAnswer: String
    
    init(question: String, correctAnswer: String, userAnswer: String) {
        
        self.question = question
        self.correctAnswer = correctAnswer
        self.userAnswer = userAnswer
        
    }
    
}
