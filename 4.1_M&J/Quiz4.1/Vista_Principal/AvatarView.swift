//
//  AvatarView.swift
//  App_Quizzes
//
//  Created by jorge suarez on 26/11/24.
//
import SwiftUI

struct AvatarView: View {
    let imageUrl: URL?
    
    var body: some View {
        if let url = imageUrl {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    .shadow(color: .gray, radius: 5)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                .foregroundColor(.gray)
                .shadow(color: .gray, radius: 5)
        }
    }
}
