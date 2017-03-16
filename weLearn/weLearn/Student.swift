//
//  Student.swift
//  weLearn
//
//  Created by Karen Fuentes on 3/9/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import Foundation

class User {
    
    static let manager = User()
    private init() {}
    
    // For temporary, global storage of user info after credentials have been provided
    var name: String?
    var email: String?
    var id: String?
    var classDatabaseKey: String?
    var classroom: String?
    var image: String?
    var studentKey: String? 
    var assignments: [Assignment]?
    var grades: [(assignment: String, grade: String)]?
    var agenda: [Agenda]?
    
    func clearSingleton() {
        var strings = [name, email, id, classDatabaseKey, classDatabaseKey, image, studentKey]
        
        // Clear strings
        for index in 0..<strings.count {
            strings[index] = nil
        }
        
        // Clear the rest
        assignments = nil
        grades = nil
    }
}
