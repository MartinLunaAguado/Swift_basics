//
//  RowItem.swift
//  App_Quizzes
//
//  Created by Jorge Suarez on 26/11/24.
//

import SwiftUI

struct RowItem: View {
    let quizItem: QuizItem
    let score: Score
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                verticalLayout
            } else {
                horizontalLayout
            }
        }
    }
    
    // MARK: - Vertical Layout
    var verticalLayout: some View {
        HStack(alignment: .top, spacing: 15) {
            AvatarView(imageUrl: quizItem.attachment?.url)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(quizItem.question)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .padding(.top, 5)
                
                HStack(spacing: 10) {
                    if let url = quizItem.author?.photo?.url {
                        AsyncImage(url: url)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                            .shadow(color: .gray, radius: 5)
                    }
                    Text(quizItem.author?.profileName ?? quizItem.author?.username ?? "Anónimo")
                        .font(.subheadline)
                        .foregroundColor(quizItem.author?.username == nil ? .gray : .primary)
                }
                
                HStack(spacing: 10) {
                    favouriteIcon
                        .frame(width: 20, height: 20) // Tamaño ajustado
                    thumbIcon
                        .frame(width: 20, height: 20) // Tamaño ajustado
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Horizontal Layout
    var horizontalLayout: some View {
        HStack(alignment: .center, spacing: 15) {
            AvatarView(imageUrl: quizItem.attachment?.url)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .shadow(color: .blue.opacity(0.3), radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(quizItem.question)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                
                HStack(spacing: 10) {
                    if let url = quizItem.author?.photo?.url {
                        AsyncImage(url: url)
                            .frame(maxWidth: 30, maxHeight: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: .gray.opacity(0.5), radius: 3)
                    }
                    Text(quizItem.author?.profileName ?? quizItem.author?.username ?? "Anónimo")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 15) {
                    favouriteIcon
                        .frame(width: 25, height: 25) // Tamaño ajustado
                    thumbIcon
                        .frame(width: 25, height: 25) // Tamaño ajustado
                }
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 2)
    }
    
    // MARK: - Icons
    var favouriteIcon: some View {
        Image(systemName: quizItem.favourite ? "star.fill" : "star")
            .resizable()
            .aspectRatio(contentMode: .fit) // Mantiene proporción
            .foregroundColor(quizItem.favourite ? .yellow : .gray)
            .shadow(color: quizItem.favourite ? Color.yellow.opacity(0.5) : Color.gray.opacity(0.5), radius: 3)
    }
    
    var thumbIcon: some View {
        Image(systemName: score.acertados.contains(quizItem.id) ? "hand.thumbsup.fill" : "hand.thumbsup")
            .resizable()
            .aspectRatio(contentMode: .fit) // Mantiene proporción
            .foregroundColor(score.acertados.contains(quizItem.id) ? .green : .gray)
            .shadow(color: score.acertados.contains(quizItem.id) ? Color.green.opacity(0.5) : Color.gray.opacity(0.5), radius: 3)
    }
}
