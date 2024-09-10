//
//  ResultViewController.swift
//  Lesson 2.7 - Personal Quiz
//
//  Created by user246073 on 9/8/24.
//

import UIKit

final class ResultViewController: UIViewController {

    var questions: [Question]!
    var answersChosen: [Answer]!
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var animalDefinition: UILabel!
    private var definitionAnimal: (character: Character, description: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        definitionAnimal = typeDefinition(from: answersChosen)
        animalDefinition.numberOfLines = 0
        animalDefinition.sizeToFit()
        resultLabel.text = "Вы - \(definitionAnimal.character)"
        animalDefinition.text = definitionAnimal.description
        animalDefinition.lineBreakMode = .byWordWrapping

    }
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

private extension ResultViewController {
    private func typeDefinition(from answersChosen: [Answer]) -> (character: Character, description: String) {
        var animalCount: [Animal: Int] = [:]
        
        for answer in answersChosen {
            let animal = answer.animal
            animalCount[animal, default: 0] += 1
        }
        
        let mostCommonAnimal = animalCount.max { a, b in
            a.value < b.value
        }?.key
        
        return (mostCommonAnimal?.rawValue ?? "❓", mostCommonAnimal?.definition ?? "Описание не найдено")
    }}
