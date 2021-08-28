//
//  TestView.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/27/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    @State var showResults = false
    
    var body: some View {
        
        if model.currentQuestion != nil && showResults == false {
            VStack (alignment:.leading) {
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                
                // Question
                CodeTextView()
                    .padding(.leading, 20)
                
                // Answers
                ScrollView {
                        VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) {index in
                            
                            Button {
                                //To Do
                                selectedAnswerIndex = index
                                
                            } label: {
                                ZStack {
                                    
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height:48)
                                    } else {
                                        // Answer has been submitted
                                        // User selected the right answer
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height:48)
                                        }
                                        // User selected the wrong answer
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .red)
                                                .frame(height:48)
                                        }
                                        // This button is the right answer
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height:48)
                                        } else {
                                            RectangleCard(color: .white)
                                                .frame(height:48)
                                        }
                                    }
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                            
                            }
                        }
                    .accentColor(.black)
                    .padding()
                }
            
                Button {
                    // Check if answer has been submitted
                    if submitted == true {
                        
                        // Check if the last Question
                        if model.currentQuestionIndex + 1 ==  model.currentModule!.test.questions.count {
                            showResults = true
                        } else {
                            // Answer has already been submitted move to next question
                            model.nextQuestion()
                            
                            // Reset Properties
                            submitted = false
                            selectedAnswerIndex = nil
                        }
                    }
                    else{
                        submitted = true
                        // Check the answer an increment
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                         numCorrect += 1
                        }
                    }
                } label: {
                    ZStack{
                        RectangleCard(color: selectedAnswerIndex == nil ? .gray : .green)
                            .frame(height:48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
            }
            
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else if showResults == true {
            // Do Nothing
            TestResultView(numCorrect:numCorrect)
        } else {
            ProgressView()
        }
        
        
    }
    
    var buttonText: String {
        // Check if answer has been submitted
        if submitted == true {
            if model.currentQuestionIndex + 1 ==  model.currentModule!.test.questions.count {
                return "Finish"
            }
            else {
                return "Next Question"
            }
            
        } else {
            return "Submit"
        }
    }
}
