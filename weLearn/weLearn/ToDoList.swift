//
//  ToDoList.swift
//  weLearn
//
//  Created by Victor Zhong on 3/20/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import Foundation

enum ToDoListGradeModelParseError: Error {
    case results, parsingResults
}

class ToDoList {
    let date: String
    let contentString: String
    
    init (date: String, contentString: String) {
        self.date = date
        self.contentString = contentString
    }
    
    convenience init?(from dict: [String:Any]) throws {
        guard let titleField = dict["title"] as? [String : Any],
            let date = titleField["$t"] as? String,
            let contentField = dict["content"] as? [String : Any],
            let contentString = contentField["$t"] as? String else {
                throw ToDoListGradeModelParseError.parsingResults
        }
        
        
        self.init(date: date, contentString: contentString)
    }
    
    static func getToDoBucket(from data: Data) -> [ToDoList]? {
        var toDoLists: [ToDoList]? = []
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let result = jsonData as? [String : Any],
                let feed = result["feed"] as? [String : Any],
                let entries = feed["entry"] as? [[String : Any]] else {
                    throw ToDoListGradeModelParseError.results
            }
            
            for entry in entries {
                if let checklistDict = try ToDoList(from: entry) {
                    toDoLists?.append(checklistDict)
                }
            }
        }
            
        catch {
            print("You got an error: \(error)")
        }
        
        return toDoLists
    }
    
    static func getTodaysList(from data: Data) -> [String]? {
        let entries = getToDoBucket(from: data)
        
        let today = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "M/dd/yyyy"
        let todaysDate = dateformatter.string(from: today)
        if let entries = entries {
            for entry in entries where entry.date == todaysDate {
                return generateCheckList(entry)
            }
        }
        
        return nil
    }
    
    static func generateCheckList(_ list: ToDoList?) -> [String] {
        if let list = list {
            return parseContentString(list.contentString) ?? ["Do your best", "Study hard", "Get sleep"]
        }
        return ["Do your best", "Study hard", "Get sleep"]
    }
    
    static func parseContentString(_ string: String) -> [String]? {
        let weirdArr = string.components(separatedBy: ": ")
        return weirdArr[1].components(separatedBy: ", ")
    }
    
    
}
