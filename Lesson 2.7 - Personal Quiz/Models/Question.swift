//
//  Question.swift
//  Lesson 2.7 - Personal Quiz
//
//  Created by user246073 on 9/8/24.
//

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]

   static func getQuestion() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морьков", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравиться больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)]
            ),
            Question(
                title: "Любите вы поесть прямо в машине",
                type: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .turtle),
                    Answer(title: "Не замечаю", animal: .dog),
                    Answer(title: "Обожаю", animal: .rabbit)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"

    var definition: String {
        switch self {
        case .dog:
            "Вам нравиться быть с друзьями. Вы окружаете себя людьми, которые вам нравиться и всегда готовы помочь. "
        case .cat:
            "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество"
        case .rabbit:
            "Вам нравиться все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            "Ваша сила - в мудрости. Медленый и вдумчивий выигрывает на больших дистанциях."
        }
    }
}

