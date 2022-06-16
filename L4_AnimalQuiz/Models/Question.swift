//
//  Question.swift
//  L4_AnimalQuiz
//
//  Created by Vitaly Zubenko on 13.05.2022.
//

enum ResponseType {
    case single
    case multiple
    case range
}

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}

//расширение для класса (структуры?)
//метод который будет возвращать нам вопрос
//можем сделать static потому что позволяет задача. Мы не можем вызывать два опроса одновременно, зачем
//мы вернем массив объектов вопросов куэшчин
extension Question {
    static func getQuestion() -> [Question] {
        return [
            Question(text: "Какую пищу вы предпочитаете?",
                     type: .single,
                     answers: [
                        Answer(text: "Стейк", type: .dog),
                        Answer(text: "Рыбка", type: .cat),
                        Answer(text: "Морковь", type: .rabbit),
                        Answer(text: "Кукуруза", type: .turtle)
                     ]
            ),
            Question(text: "Что вы любите делать больше всего?",
                     type: .multiple,
                     answers: [
                        Answer(text: "Плавать", type: .dog),
                        Answer(text: "Спать", type: .cat),
                        Answer(text: "Обниматься", type: .rabbit),
                        Answer(text: "Есть", type: .turtle)
                     ]
            ),
            Question(text: "Любите ли вы поездки на машине?",
                     type: .range,
                     answers: [
                        Answer(text: "Обожаю", type: .dog),
                        Answer(text: "Люблю", type: .cat),
                        Answer(text: "Интересно", type: .rabbit),
                        Answer(text: "Ненавижу", type: .turtle)
                     ]
            )
        ]
    }
}
