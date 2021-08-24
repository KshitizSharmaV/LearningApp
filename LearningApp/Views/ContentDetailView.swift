//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/24/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if we get a valid URL
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            if model.hasnextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .shadow(radius: 5)
                            .cornerRadius(10)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
            
        }
        .padding(.horizontal)
    }
}

