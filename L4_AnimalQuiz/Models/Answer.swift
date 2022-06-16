//
//  Answer.swift
//  L4_AnimalQuiz
//
//  Created by Vitaly Zubenko on 13.05.2022.
//

//структура ответа, тоесть из чего состоит ответ на экране ответов
struct Answer {
    let text: String
    let type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Собака улыбака"
        case .cat:
            return "Кошка хитрошка"
        case .rabbit:
            return "Кролик красотулик"
        case .turtle:
            return "Черепашка шумахеражка"
        }
    }
    //перечисление которое хранит весь ответ: животных и описания к ним
}
