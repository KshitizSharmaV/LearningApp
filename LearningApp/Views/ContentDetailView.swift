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
            
            // Code Text View
            CodeTextView()
            
            // Show Next Lesson
            if model.hasnextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        RectangleCard(color:Color.green)
                            .frame(height:48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            } else {
                // Show the complete button
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color:Color.green)
                            .frame(height:48)
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
            
        }
        .padding(.horizontal)
        .navigationBarTitle(lesson?.title ?? "")
    }
}

