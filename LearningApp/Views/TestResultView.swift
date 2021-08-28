//
//  TestResultView.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/27/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    var numCorrect: Int
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
         return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if pct > 0.5 {
            return "Awesome"
        }
        else if pct > 0.2 {
            return "Doing Great"
        }
        else {
            return "Keep Learning"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(resultHeading)
                .font(.title)
            Spacer()
            Text("You got \(numCorrect) Out of \(model.currentModule?.test.questions.count ?? 0) Questions")
            Spacer()
            Button {
                model.currentTestSelected  = nil
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height:48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            Spacer()
            
        }
        .padding()
    }
}

