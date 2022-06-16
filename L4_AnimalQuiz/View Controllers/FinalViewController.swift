//
//  FinalViewController.swift
//  L4_AnimalQuiz
//
//  Created by Vitaly Zubenko on 12.05.2022.
//

import UIKit

class FinalViewController: UIViewController {
    @IBOutlet var resultEmoji: UILabel!
    @IBOutlet var resultDescription: UILabel!
    
    var answers: [Answer]!
    
//    var answersChosen: [Answer] = []
//    var dog = 0
//    var cat = 0
//    var rabbit = 0
//    var turtle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        showResult()
    }
    
//        if dog > cat && dog > rabbit && dog > turtle {
//            resultEmoji.text = "Вы - 🐶"
//            resultDescription.text =
//        } else if cat > dog && cat > rabbit && cat > turtle {
//            resultEmoji.text = "Вы - 🐶"
//
//        }
    
}

// MARK: Private Methods
extension FinalViewController {
    
    private func showResult() {
//        var frequencyOfAnimals: [AnimalType: Int] = [:]
//        let animals = answers.map { $0.type }
        
        // VAR 1
//        for animal in animals {
//            if let animalTypeCount = frequencyOfAnimals[animal] {
//                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
//            } else {
//                frequencyOfAnimals[animal] = 1
//            }
//        }
        
        // VAR 2
//        for animal in animals {
//            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
//        }
//
//        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
//        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        // VAR 3 (magic)
        // решение в одну строку
        let mostFrequencyAnimal = Dictionary(grouping: answers, by: { $0.type })
            .sorted(by: { $0.value.count > $1.value.count })
            .first?.key
        
        updateUI(with: mostFrequencyAnimal)
        
    }
    
    private func updateUI(with animal: AnimalType?) {
        resultEmoji.text = "Вы - \(animal?.rawValue ?? "🐶")!" //в скобочки напрямую mostFrequencyAnimal нельзя передать, поэтому надо добавить параметр, через который можно передать эту константу вызвав эту функцию из предыдущей
        resultDescription.text = animal?.definition ?? ""
    }
}
