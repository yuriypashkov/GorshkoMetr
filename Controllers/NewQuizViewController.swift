
import UIKit

var answerBank = [Answer]()

class NewQuizViewController: UIViewController {

    @IBOutlet weak var buttonsStackView: UIStackView!
    
    @IBOutlet weak var questionCounter: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var buttonMore: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var closeImage: UIImageView!
    
    @IBOutlet var arrayOfButtons: [UIButton]!
    
    let defaults = UserDefaults.standard
    
    var allQuestions = QuestionBank()
    var questionNumber = 0
    var score = 0
    
    var correctAnswers: Int = 0 {
        didSet {
            defaults.set(correctAnswers, forKey: "correctAnswers")
        }
    }
    
    var quizPassed: Int = 0 {
        didSet {
            defaults.set(quizPassed, forKey: "quizPassed")
        }
    }
    
    var answersCount: Int = 0 {
        didSet {
            defaults.set(answersCount, forKey: "answersCount")
        }
    }
    
    var selectedAnswer = 0
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    @IBAction func refreshButtonTap(_ sender: UIButton) {
        restartQuiz()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // уменьшим высоту блока с кнопками для SE первого поколения, на остальных норм вроде скейлится
        if UIScreen.main.bounds.height < 667 {
            if let height = (buttonsStackView.constraints.filter{ $0.firstAttribute == .height}.first) {
                height.constant = 150
            }
        }
        
        buttonMore.isHidden = true
        refreshButton.isHidden = true
        
        answerBank.removeAll()
        updateQuestion()
        updateUI()
        
        //get correctAnswers
        correctAnswers = defaults.integer(forKey: "correctAnswers")
        //get quizPassed
        quizPassed = defaults.integer(forKey: "quizPassed")
        //get answersCount
        answersCount = defaults.integer(forKey: "answersCount")
        
        //recognizer on close image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTap(_:)))
        closeImage.isUserInteractionEnabled = true
        closeImage.addGestureRecognizer(tapGestureRecognizer)
        
        //autoshrink on buttons
        for button in arrayOfButtons {
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        
    }
    
    @objc func imageTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        answersCount += 1
        
        if sender.tag == selectedAnswer {
            score += 1
            correctAnswers += 1
            //sender.backgroundColor = .systemGreen
            sender.setTitleColor(.systemGreen, for: .normal)
        } else {
            //sender.backgroundColor = .systemRed
            sender.setTitleColor(.systemRed, for: .normal)
        }
        
//        for button in arrayOfButtons {
//            button.isEnabled = false
//        }
        
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
        answerBank.append(Answer(question: question, correctAnswer: correctAnswer, userAnswer: userAnswer))
        

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateQuestion()
            self.updateUI()
            for button in self.arrayOfButtons {
                //button.isEnabled = true
                //button.backgroundColor = .clear
                button.setTitleColor(.black, for: .normal)
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
            quizPassed += 1
            
        }
    }
    
    func setButtonsHidden(state: Bool) {
        optionA.isHidden = state
        optionB.isHidden = state
        optionC.isHidden = state
        optionD.isHidden = state
        buttonMore.isHidden = !state
        refreshButton.isHidden = !state
        answersStackView.isHidden = state
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
