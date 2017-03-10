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
    
    var agenda = LessonSchedule.manager.agenda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Agenda"
        
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: "AgendaTableViewCell")
        
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agenda.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath)
        
        let agendaAtRow = agenda[indexPath.row]
        
        cell.textLabel?.text = "\(agendaAtRow.dateString) - \(agendaAtRow.lessonName)\n\(agendaAtRow.lessonDesc)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let url = agenda[indexPath.row].repoURL {
            
            let svc = SFSafariViewController(url: URL(string: url)!)
            present(svc, animated: true, completion: nil)
        }
        
    }
}
