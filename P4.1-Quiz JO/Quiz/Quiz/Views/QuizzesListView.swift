import SwiftUI

struct QuizzesListView : View {
	@Environment (QuizzesModel.self) var quizzesModel
    @Environment (ScoresModel.self) var scoreModels
	
	var body : some View {
		NavigationStack {
			List{
				ForEach(quizzesModel.quizzes) {quizItem in
					NavigationLink {
                        QuizItemPlayView(quizItem: quizItem)
					} label: {
						QuizItemRowView(quizItem: quizItem)
					}
				}
			}
			.listStyle(.plain)
            
			.navigationTitle("P4 Quizzes")
		}
		.onAppear(perform: {
			guard quizzesModel.quizzes.count == 0
			else {return}
			quizzesModel.load()
		})
		.padding()
        .background(Color(uiColor: .systemGreen).opacity(0.1))     //borde color verde
    }
}

#Preview {
	QuizzesListView()
}
