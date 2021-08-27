//
//  ContentModel.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/23/21.
//

import Foundation


class ContentModel: ObservableObject {

    // List of Modules
    @Published var modules = [Module]()
    
    // Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    
    init() {
        getLocalData()
    }
    
    // Mark: - Data Methods
    func getLocalData() {
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource:"data", withExtension: "json")
        
        do{
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from:jsonData)
            self.modules = modules
        }
        catch {
            print("Couldn't parse local data")
        }
        
        let styleUrl = Bundle.main.url(forResource:"style", withExtension: "html")
        do {
            // Parse the style data
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch{
            print("Couldn't parse style data")
        }
    }
    
    // Mark: - Module Navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }

    
    func beginLesson(_ lessonIndex:Int) {
        
        // Find the index for this module id
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else{
            currentLessonIndex = 0
        }
        // Set the current module
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
        // Set the current explanation
        // lessonDescription = currentLesson?.explanation
    }
    
    func hasnextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentModule = nil
        }
    }
    
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil{
            data.append(self.styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data:data, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil ) {
            resultString = attributedString
        }
        
        return resultString
    }
    
}
