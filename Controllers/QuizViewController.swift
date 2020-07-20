
import UIKit

var answerBank = [Answer]()

class QuizViewController: UIViewController {

    @IBOutlet weak var questionCounter: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var arrayOfButtons: [UIButton]!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var buttonMore: UIButton!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshButtonTap(_ sender: UIButton) {
        restartQuiz()
    }
    
    @IBAction func tapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var allQuestions = QuestionBank()
    var questionNumber = 0
    var score = 0
    var selectedAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonMore.isHidden = true
        refreshButton.isHidden = true
        
        answerBank.removeAll()
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        updateQuestion()
        updateUI()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            score += 1
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
        }
        
        for button in arrayOfButtons {
            button.isEnabled = false
        }
        
        //добавляем данные в массив ответов
        let tempNumber = questionNumber - 1
        let question = allQuestions.list[tempNumber].question
        var correctAnswer: String {
            switch allQuestions.list[tempNumber].correctAnswer {
            case 1:
                return allQuestions.list[tempNumber].optionA
            case 2:
                return allQuestions.list[tempNumber].optionB
            case 3:
                return allQuestions.list[tempNumber].optionC
            case 4:
                return allQuestions.list[tempNumber].optionD
            default:
                return "none"
            }
        }
        let userAnswer = sender.currentTitle!
        //print("\(question) AND \(correctAnswer) AND \(userAnswer)")
        answerBank.append(Answer(question: question, correctAnswer: correctAnswer, userAnswer: userAnswer))
        
        updateQuestion()
        updateUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for button in self.arrayOfButtons {
                button.isEnabled = true
                button.backgroundColor = .black
            }
        }
        
    }
    
    func updateQuestion() {
        if questionNumber < allQuestions.list.count {
            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: .normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: .normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: .normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: .normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            questionNumber += 1
        } else {
            //buttonsView.isHidden = true
            let result = Float (score) / Float(allQuestions.list.count) * 100
            var status = "none"
            switch result {
            case 0..<35:
                status = "Поручик"
            case 35..<67:
                status =  "Князь"
            default:
                status = "Горшок"
            }
            questionLabel.text = """
            Поздравляем! Вы ответили правильно на \(score) из \(allQuestions.list.count) вопросов.\n
            Ваш титул - \(status)
            """
            setButtonsHidden(state: true)
        }
    }
    
    func setButtonsHidden(state: Bool) {
        optionA.isHidden = state
        optionB.isHidden = state
        optionC.isHidden = state
        optionD.isHidden = state
        buttonMore.isHidden = !state
        refreshButton.isHidden = !state
    }
    
    func updateUI() {
        questionCounter.text = "\(questionNumber)/\(allQuestions.list.count)"
    }
    
    func restartQuiz() {
        allQuestions.createListOfData(questionCount: 7)
        score = 0
        questionNumber = 0
        updateQuestion()
        updateUI()
        answerBank.removeAll()
        setButtonsHidden(state: false)
    }
    
}
