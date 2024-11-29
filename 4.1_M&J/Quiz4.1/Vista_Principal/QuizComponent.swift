import SwiftUI

struct QuizComponent: View {
    var quizzesModel: QuizzesModel
    var score: Score
    
    // Lista de colores suaves para el fondo y los bordes
    private let colors: [Color] = [
        Color.blue.opacity(0.2),
        Color.green.opacity(0.2),
        Color.purple.opacity(0.2),
        Color.orange.opacity(0.2),
        Color.red.opacity(0.2)
    ]
    
    var body: some View {
        NavigationView {
            // TimelineView para animación de fondo
            TimelineView(.animation) { timeline in
                // Calcula el índice del color basado en el tiempo
                let currentTime = timeline.date.timeIntervalSinceReferenceDate
                let index = Int(currentTime / 3) % colors.count
                
                ZStack {
                    // Fondo animado que cubre toda la pantalla
                    colors[index]
                        .edgesIgnoringSafeArea(.all) // Asegura que el fondo cubra toda la pantalla
                        .animation(.easeInOut(duration: 3), value: currentTime)
                    
                    VStack {
                        List {
                            ForEach(quizzesModel.quizzes) { quizItem in
                                NavigationLink(destination: RowView(quizItem: quizItem, score: score)) {
                                    RowItem(quizItem: quizItem, score: score)
                                        .padding(16)
                                        .background(
                                            Color.white
                                                .opacity(0.8)
                                        )
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(colors[index], lineWidth: 2) // Cambio dinámico de color en el borde
                                        )
                                        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                        .padding(.bottom, 8)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            HStack(spacing: 15) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.green)
                                    .padding(5)
                                    .background(Circle().fill(Color.white.opacity(0.8)))
                                    .shadow(radius: 5)
                                
                                VStack(alignment: .leading) {
                                    Text("Score")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    
                                    Text("\(score.acertados.count) de \(quizzesModel.quizzes.count)")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .navigationTitle("Quizzes")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}
