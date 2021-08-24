//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/24/21.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        // Lesson Card
        ZStack(alignment:.leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 5)
                .frame(height: 66)
                .padding(.horizontal)
            
            HStack(spacing:30) {
                Text(String(index+1))
                    .bold()
                    .padding()
                    
                VStack(alignment:.leading) {
                    Text("\(lesson.title)")
                        .font(.title3)
                        .bold()
                    Text("Video - \(lesson.duration)")
                        .font(.caption)
                }
            }
            .padding()
        }
    }
}

