//
//  LessonSchedule.swift
//  weLearn
//
//  Created by Victor Zhong on 3/9/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import Foundation

class LessonSchedule {
    
    static let manager = LessonSchedule()
    private init() {}
    
    var agenda: [Agenda] = []
    
    func setAgenda(_ array: [Agenda]) {
        
        let reversedSorted = array.sorted(by: {$0.date > $1.date})
        let today = Date()
        for entry in reversedSorted {
            if today >= entry.date  {
                agenda.append(entry)
            }
        }
        
        print("\n\n\n\n\nWe have a lesson schedule: \(agenda.count) entries")
    }
}
