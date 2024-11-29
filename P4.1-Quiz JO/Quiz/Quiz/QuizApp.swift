
import SwiftUI
import SwiftData
@main
struct QuizApp: App {

    @State var quizzesModel = QuizzesModel()
    @State var scoresModel = ScoresModel()
    
    var body: some Scene{
        WindowGroup {
            QuizzesListView()
                .environment(quizzesModel)          //environments
                .environment(scoresModel)
        }
    }
}
