import SwiftUI

import Foundation



struct QuizItemPlayView : View {

    @Environment (ScoresModel.self) var scoresModel

    @Environment(\.verticalSizeClass) var vsc

    var quizItem: QuizItem
    
    @State var answer: String = ""

    @State var showCheckAlert = false

    var body : some View {
        VStack {
            titulo    
            if vsc == .compact{
                HStack{
                    VStack{
                        Spacer()
                        pregunta
                        Spacer()
                        HStack{
                            puntos
                            Spacer()
                            autor
                        }
                    }
                    adjunto
                }
            }else{
                VStack{
                    Spacer()
                    pregunta
                    Spacer()
                    adjunto
                    Spacer()
                    HStack{
                        puntos
                        Spacer()
                        autor
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Playing")
    }
    private var puntos: some View{
        Text("\(scoresModel.acertadas.count)")
        .font(.title)
        .fontWeight(.bold)
        .foregroundStyle(.blue	)
    }

    private var pregunta: some View{
        VStack{
            TextField("Respuesta", text: $answer)
                .textFieldStyle(.roundedBorder)
            Button("Comprobar") {
                showCheckAlert = true
                scoresModel.check(quizItem: quizItem, answer: answer)            
            }
        }
        .alert("Resultado",
               isPresented: $showCheckAlert){
        } message: {
            Text (answer =+-= quizItem.answer ? "Correcto!!" : "Mal, vuelve a intentarlo")
            
        }
    }
    
    private var titulo:  some View{
        HStack{
            Text(quizItem.question)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Image(quizItem.favourite ? "star_yellow" : "star_grey")
        }
    }

    private var adjunto: some View{                 
        GeometryReader { geometry in 
            EasyAsyncImage(url: quizItem.attachment?.url)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scaledToFit()
                .hueRotation(Angle(degrees: showCheckAlert ? 180 : 0))
                .rotationEffect(Angle(degrees: showCheckAlert ? 180 : 0))
                .animation(.easeInOut, value: self.showCheckAlert)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .contentShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0).stroke(Color.green, lineWidth: 2)
                }
                .shadow(color: .green, radius: 6, x: 0.0, y: 0.0)
        }
    }

    private var autor: some View{
        HStack{
                Spacer()
            Text(quizItem.author?.username ??  
                    quizItem.author?.profileName ??
                    "Anónimo")
                EasyAsyncImage(url: quizItem.author?.photo?.url)                  
                    .frame(width: 30, height:30)
                    .scaledToFill()
                    .clipped()
                    .contentShape(Circle())
                    .clipShape(Circle())
                    .overlay {
                    Circle().stroke(Color.blue, lineWidth: 2)
                }                                          
                    .shadow(color: Color.blue, radius: 4, x: 0.0, y: 0.0)
            }
    }

}



/*#Preview {
    var quizesmodel : QuizzesModel()
        quizesmodel.load()
        var scoremodel = ScoresModel()
       

	return NavigationStack{
        QuizItemPlayView (quizItem: quizesmodel.quizzes[0])
            .enviroment(scoremodel)
    }
 */

