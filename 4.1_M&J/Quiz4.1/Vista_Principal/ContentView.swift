//
//  ContentView.swift
//  App_Quizzes
//
//  Created by jorge suarez on 4/11/24.
//

import SwiftUI

struct ContentView: View {
    let quizzesModel = QuizzesModel()
    let score = Score()
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            QuizComponent(quizzesModel:quizzesModel,score: score)
                .onAppear{
                    quizzesModel.load()
                }
                        
        }
        .padding(.top)
        
    }
}

#Preview {
    ContentView()
}
