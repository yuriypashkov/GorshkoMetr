
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
            //button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.textAlignment = .center
        }
        
        buttonMore.titleLabel?.textAlignment = .center
        
    }
    
    @objc func imageTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    let arrayOfImagesName = ["quizBoardOne", "quizBoardTwo", "quizBoardThree", "quizBoardFour"]
    
    func setButtonImage(tag: Int, imageState: String, sender: UIButton) {
        switch tag {
        case 1:
            sender.setBackgroundImage(UIImage(named: "buttonOne\(imageState)"), for: .normal)
        case 2:
            sender.setBackgroundImage(UIImage(named: "buttonTwo\(imageState)"), for: .normal)
        case 3:
            sender.setBackgroundImage(UIImage(named: "buttonThree\(imageState)"), for: .normal)
        default:
            sender.setBackgroundImage(UIImage(named: "buttonFour\(imageState)"), for: .normal)
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        answersCount += 1
        
        if sender.tag == selectedAnswer {
            score += 1
            correctAnswers += 1
            setButtonImage(tag: sender.tag, imageState: "True", sender: sender)
        } else {
            setButtonImage(tag: sender.tag, imageState: "False", sender: sender)
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
        answerBank.append(Answer(question: question, correctAnswer: correctAnswer, userAnswer: userAnswer))
        

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateQuestion()
            self.updateUI()
            for i in 0..<self.arrayOfButtons.count {
                self.arrayOfButtons[i].setBackgroundImage(UIImage(named: self.arrayOfImagesName[i]), for: .normal)
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
            var message = "none"
            switch result {
            case 0..<10:
                status = "Неумеха"
                message = "Тебе явно надо переслушать дискографию КиШа несколько раз, это никуда не годится."
            case 10..<20:
                status = "Салага"
                message = "Откровенно говоря, результат очень слабый. Попробуй ещё, может быть это случайно так."
            case 20..<30:
                status = "Садовник"
                message = "Отвечать на вопросы - это тебе не головы братьев в букеты класть. Срочно подтягивать матчасть!"
            case 30..<40:
                status = "Весёлый тролль"
                message = "Ты не идеален в своих познаниях, но подарить праздник всем вокруг ты всё-таки можешь. Но расти есть куда."
            case 40..<50:
                status = "Лесник"
                message = "Судя по всему, ты знаешь немало историй и можешь рассказать их всем желающим"
            case 50..<60:
                status = "Старик Алонс"
                message = "Неплохой трюк, куда круче чем тот, что со стаканом. Попробуй ещё разок."
            case 60..<70:
                status = "Мастер"
                message = "Работа мастера, сразу видно. Но в гости к тебе всё равно неохота, извини."
            case 70..<80:
                status = "Живой анархист"
                message = "Крикнешь Хой - все пойдут за тобой. Твои познания в области Кишологии вызывают уважение."
            case 80..<90:
                status = "Смельчак"
                message = "Почти идеально. Ты явно не из робких и последний рубеж тебе точно по плечу."
            default:
                status = "Михаил"
                message = "Всё с тобой ясно, Миша. Для тебя нет секретов в этом квизе."
            }
            questionLabel.text = """
            Хой! Правильных ответов: \(score) из \(allQuestions.list.count) вопросов.\n
            Твой титул - \(status)
            
            \(message)
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
        allQuestions.createListOfData(questionCount: 11)
        score = 0
        questionNumber = 0
        updateQuestion()
        updateUI()
        answerBank.removeAll()
        setButtonsHidden(state: false)
    }


}
