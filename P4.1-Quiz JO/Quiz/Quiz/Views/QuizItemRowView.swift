import SwiftUI

struct QuizItemRowView : View {
    var quizItem: QuizItem
	var body : some View {

        HStack(spacing: 20) {
            
            let url = quizItem.attachment?.url
            
            EasyAsyncImage(url: url)
                .frame(width: 60, height: 60)
                .scaledToFill()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color.green, lineWidth: 2)
                }
                .shadow(color: Color.green, radius: 6, x: 0, y: 0)
            
            VStack(alignment: .leading) {
                Image(quizItem.favourite ? "star_yellow" : "star_grey")
                Text (quizItem.question)
                    .fontWeight(.bold)
            }
            EasyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 30, height: 30)
                .scaledToFill()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color.green, lineWidth: 2)
                }
                .shadow(color: Color.green, radius: 6, x: 0, y: 0)
        }
    }
}


/*#Preview {
	var model: QuizzesModel = {
        var quizesmodel = QuizzesModel()
        quizesmodel.load()
        return quizesmodel
    }()
    return QuizItemRowView(quizItem, model.quizzes[0])
}*/
