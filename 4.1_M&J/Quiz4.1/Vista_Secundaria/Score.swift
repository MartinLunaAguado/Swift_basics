//
//  Score.swift
//  App_Quizzes
//
//  Created by jorge suarez on 26/11/24.
//


import Foundation

@Observable class Score{
    private(set) var acertados : Set<Int> = []
    
    func add (_ quizItem: QuizItem){
        acertados.insert(quizItem.id)
    }
}
