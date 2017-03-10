//
//  AgendaTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 3/8/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//
import UIKit
import SafariServices


class AgendaTableViewController: UITableViewController {
    var todaysFakeSchedule: [String] = [
        "DSA",
        "Sprite Kit with Louis",
        "Capstone",
        "Lunch break",
        "Talk to Tech Mentors",
        "Workshop at Headquarters"
    ]
    
    //var agenda = LessonSchedule.manager.agenda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Syllabus"
        
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: "AgendaTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
                //readAgenda()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "March 10, 2017"
            //        case 0:
            //            //            if todaysAgenda != nil {
            //            return "Today's Schedule"
            //            }
            //            else {
            //                return nil
        //            }
        case 1:
            return "March 09, 2017"
        case 2:
            return "March 07, 2017"
        default:
            return ""
        }
    }
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysFakeSchedule.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
        
        let agendaAtRow = todaysFakeSchedule[indexPath.row]
        
        cell.label.text = agendaAtRow
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        if let url = agenda[indexPath.row].repoURL {
//            
//            let svc = SFSafariViewController(url: URL(string: url)!)
//            present(svc, animated: true, completion: nil)
//        }
//        
//    }
}
