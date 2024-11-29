import Foundation

@Observable class ScoresModel {

    var acertadas: Set<Int> = []
    
    func check(quizItem: QuizItem, answer: String){
        if answer =+-=  quizItem.answer {    
            acertadas.insert(quizItem.id)
        }
    }
    
}
