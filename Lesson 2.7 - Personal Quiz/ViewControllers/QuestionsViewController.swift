//
//  QuestionsViewController.swift
//  Lesson 2.7 - Personal Quiz
//
//  Created by user246073 on 9/8/24.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitch: [UISwitch]!
    
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    
    // MARK: - Private Properties
    private var questionIndex = 0
    private let questions = Question.getQuestion()
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        let answersCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answersCount
        rangedSlider.value = answersCount / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let resultVC = segue.destination as? ResultViewController else {
                return
            }
        resultVC.questions = questions
        resultVC.answersChosen = answersChosen
    }
    // MARK: - IB Action
    @IBAction func singleQuestionButtonAction(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func rangedQuestionButtonAction() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    @IBAction func multipleQuestionButtonAction() {
        for (multipleSwitch, answer) in zip(multipleSwitch, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
}

// MARK: - Private Methods
private extension QuestionsViewController {
    func updateUI() {
        // Hide everything
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        // Set navigation title
        title = "Вопрос №  \(questionIndex + 1) из \(questions.count)"
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for label
        questionLabel.text = currentQuestion.title
        
        //Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //Set progress for progressQuestion
        questionProgressView.setProgress(totalProgress, animated: true)
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    
    /// Choice of answer
    ///
    ///Dissplaying answer to a question sccording to category
    ///
    /// - Parameter type: Specifies the catagory of response
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answer: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answer) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answer: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answer.first?.title
        rangedLabels.last?.text = answer.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

