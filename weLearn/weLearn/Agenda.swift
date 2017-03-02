//
//  Agenda.swift
//  weLearn
//
//  Created by Victor Zhong on 3/1/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import Foundation

enum AgendaModelParseError: Error {
    case results, parsingResults
}

class Agenda {
    var lessonName: String
    
    init(lessonName: String) {
        self.lessonName = lessonName
    }
    
    convenience init?(from dict: [String:Any]) throws {
           guard let titleField = dict["title"] as? [String : Any],
            let lessonName = titleField["$t"] as? String else {
                
                throw AgendaModelParseError.parsingResults
        }
        
        self.init(lessonName: lessonName)
    }
    
    static func getAgenda(from data: Data) -> [Agenda]? {
        var agenda: [Agenda]? = []
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let result = jsonData as? [String : Any],
                let feed = result["feed"] as? [String : Any],
                let entry = feed["entry"] as? [[String : Any]] else {
                    throw AgendaModelParseError.results
            }
            
            for each in entry {
                if let agendaDict = try Agenda(from: each) {
                    agenda?.append(agendaDict)
                }
            }
        }
            
        catch {
            print("You got an error: \(error)")
        }
        
        return agenda
    }
}
