//
//  ContentView.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/23/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    var body: some View {
        
        NavigationView {
            VStack(alignment:.leading) {
                Text("What do you want to do today?")
                    .padding()
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            
                            NavigationLink(
                                destination: ContentView()
                                    .onAppear(perform: {
                                        model.beginModule(module.id)
                                    }),
                                tag:module.id,
                                selection: $model.currentContentSelected,
                                label: {
                                    // Learning Card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                })
                            
                            NavigationLink(
                                destination: TestView()
                                    .onAppear(perform: {
                                        model.beginTest(module.id)
                                    }),
                                tag: module.id,
                                selection: $model.currentTestSelected) {
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                }
                            
                            NavigationLink(
                                destination: EmptyView()
                            ) {
                                EmptyView()
                            }
                            
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
