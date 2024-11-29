import SwiftUI

struct RowView: View {
    var quizItem: QuizItem
    @State private var userAnswer: String = ""
    @State var isCorrect: Bool = false
    @State var showAlert: Bool = false
    @State var isScreenGray: Bool = false
    @State private var currentTime: TimeInterval = 0
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var score: Score
    
    // Lista de colores suaves para el fondo
    private let colors: [Color] = [
        Color.blue.opacity(0.2),
        Color.green.opacity(0.2),
        Color.purple.opacity(0.2),
        Color.orange.opacity(0.2),
        Color.red.opacity(0.2)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // TimelineView para la animación del fondo
            TimelineView(.animation) { timeline in
                // Actualiza el tiempo de la animación
                let time = timeline.date.timeIntervalSinceReferenceDate
                let index = Int(time / 3) % colors.count
                
                ZStack {
                    // Fondo animado que cubre toda la pantalla
                    colors[index]
                        .edgesIgnoringSafeArea(.all)
                        .animation(.easeInOut(duration: 3), value: time)
                    
                    VStack {
                        if verticalSizeClass == .compact {
                            horizontalLayout
                        } else {
                            verticalLayout
                        }
                        
                        TextField("Escribe tu respuesta...", text: $userAnswer)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                            .padding(.horizontal)
                        
                        Button(action: verifyAnswer) {
                            Text("Comprobar")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(isCorrect ? "🎉 ¡Bien hecho! 🎉" : "😢 Lo siento 😢"),
                                message: Text(isCorrect ? "✅ Intenta otro quiz" : "❌ Inténtalo de nuevo"),
                                dismissButton: .default(Text("Cerrar")) {
                                    isScreenGray = false
                                }
                            )
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
    // MARK: - Layouts
    
    var verticalLayout: some View {
        VStack(spacing: 20) {
            quizImage
            
            quizQuestion
            userInfo
            HStack {
                favouriteIcon
                scoreIcon
            }
        }
        .padding()
    }
    
    var horizontalLayout: some View {
        HStack(spacing: 20) {
            quizImage
            VStack(alignment: .leading, spacing: 10) {
                quizQuestion
                    
                userInfo
                HStack {
                    favouriteIcon
                    scoreIcon
                }
            }
        }
    }
    
    // MARK: - Components
    
    var quizImage: some View {
        Group {
            if let url = quizItem.attachment?.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150, height: 150)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.blue, lineWidth: 4))
        .shadow(color: Color.blue.opacity(0.3), radius: 10)
    }
    
    var quizQuestion: some View {
        Text(quizItem.question)
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .lineLimit(nil) // Permite que el texto ocupe múltiples líneas si es necesario
            .fixedSize(horizontal: false, vertical: true) // Permite que el texto se expanda verticalmente
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
            .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
            .frame(maxWidth: .infinity, alignment: .center) // Asegura que el texto ocupe el espacio disponible
    }

    
    var userInfo: some View {
        HStack(spacing: 10) {
            if let url = quizItem.author?.photo?.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
            }
            
            Text(quizItem.author?.username ??
                 quizItem.author?.profileName ??
                 "Anónimo")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
    
    var favouriteIcon: some View {
        Image(systemName: quizItem.favourite ? "star.fill" : "star")
            .resizable()
            .frame(width: 35, height: 35)
            .foregroundColor(quizItem.favourite ? .yellow : .gray)
            .shadow(color: quizItem.favourite ? Color.yellow.opacity(0.6) : Color.gray.opacity(0.6), radius: 6, x: 0, y: 3)
    }
    
    var scoreIcon: some View {
        Image(systemName: score.acertados.contains(quizItem.id) ? "hand.thumbsup.fill" : "hand.thumbsup")
            .resizable()
            .frame(width: 35, height: 35)
            .foregroundColor(score.acertados.contains(quizItem.id) ? .green : .gray)
            .shadow(color: score.acertados.contains(quizItem.id) ? Color.green.opacity(0.6) : Color.gray.opacity(0.6), radius: 6, x: 0, y: 3)
    }
    
    // MARK: - Actions
    
    private func verifyAnswer() {
        if userAnswer.lowercased() == quizItem.answer.lowercased() {
            score.add(quizItem)
            isCorrect = true
            isScreenGray = false
        } else {
            isCorrect = false
            isScreenGray = true
        }
        showAlert = true
    }
}
