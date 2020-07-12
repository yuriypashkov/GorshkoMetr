//
//  QuizViewController.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/12/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import UIKit

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
    
    @IBAction func tapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var allQuestions = QuestionBank()
    var questionNumber = 0
    var score = 0
    var selectedAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            buttonsView.isHidden = true
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
        }
    }
    
    func updateUI() {
        questionCounter.text = "\(questionNumber)/\(allQuestions.list.count)"
    }
    
    func restartQuiz() {
        score = 0
        questionNumber = 0
        updateQuestion()
        updateUI()
    }
    
}
