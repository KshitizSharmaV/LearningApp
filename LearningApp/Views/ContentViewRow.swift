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

    var lesson: Lesson {
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        } else {
            return Lesson(id:0, title: "", video: "", duration: "", explanation:"")
        }
    }
    
    var body: some View {
        
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

