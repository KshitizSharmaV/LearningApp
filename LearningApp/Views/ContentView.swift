//
//  ContentView.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                       
                        NavigationLink(
                            destination:
                                ContentDetailView()
                                    .onAppear(perform: {
                                        model.beginLesson(index)
                                    }),
                        label: {
                            ContentViewRow(index:index)
                        })
                        
                    }
                }
            }
        .padding()
        .accentColor(.black)
        .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
