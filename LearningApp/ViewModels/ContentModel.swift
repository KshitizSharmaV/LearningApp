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
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current Lesson Description
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        getLocalData()
        
        // Download Remote json file and parse data
        getRemoteData()
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
    
    func getRemoteData() {
        let urlString = "https://kshitizsharmav.github.io/learningapp-data/data2.json"
        let url = URL(string: urlString)
        guard url != nil else{
            return
        }
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        // Get the session and kick off the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) {(data, response, error) in
            
            // Check if there's an error
            guard error == nil else {
                // There was an error
                return
            }
            
            
            // Handle the response
            do {
                // create the json decoder
                let jsonDecoder = JSONDecoder()
                let modules = try jsonDecoder.decode([Module].self, from:data!)
                
                DispatchQueue.main.async {
                    self.modules += modules
                }
            }
            catch {
                // Couldn't parse the json
            }
        }
        
        // Kick off the data task
        dataTask.resume()
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
        codeText = addStyling(currentLesson!.explanation)
        // Set the current explanation
        // lessonDescription = currentLesson?.explanation
    }
    
    func hasnextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            DispatchQueue.main.async() {
                self.currentLesson = self.currentModule!.content.lessons[self.currentLessonIndex]
                self.codeText = self.addStyling(self.currentLesson!.explanation)
            }
        }
        else {
            currentLessonIndex = 0
            currentModule = nil
        }
    }
    
    
    func beginTest(_ moduleId:Int) {
        
        // Set the current module
        beginModule(moduleId)
        
        // Set the current Question
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
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
