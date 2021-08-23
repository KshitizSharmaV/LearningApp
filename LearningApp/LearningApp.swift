//
//  LearningApp.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/23/21.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
