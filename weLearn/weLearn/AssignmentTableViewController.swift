//
//  HomeworkTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAuth

class AssignmentTableViewController: UITableViewController, Tappable {
    
    var assignments = User.manager.assignments
    var stopTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Assignments"
        self.tabBarController?.title = navigationItem.title
        
        tableView.register(AssignmentTableViewCell.self, forCellReuseIdentifier: "AssignmentTableViewCell")
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        let rightButton = UIBarButtonItem(customView: logOutButton)
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        logOutButton.addTarget(self, action: #selector(logOutButtonWasPressed(selector:)), for: .touchUpInside)
        
        //        fakePopulate([Assignment(date: "March 21, 2017", assignmentTitle: "Capstone", score: stopTime, url: nil), Assignment(date: "Feb 14, 2017", assignmentTitle: "Final", score: "A", url: "https://github.com/C4Q/AC3.2-Final"), Assignment(date: "October 1, 2016", assignmentTitle: "Battleship Homework", score: "A+", url: "https://github.com/jgresh/Battleship"), Assignment(date: "September 20, 2016", assignmentTitle: "Tableview Exam", score: "A", url: "https://github.com/martyav/EmojiDeck")])
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    func fakePopulate(_ items: [Assignment]) {
        self.assignments = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func cellTapped(cell: UITableViewCell) {
        self.repoButtonClicked(at: tableView.indexPath(for: cell)!)
    }
    
    func repoButtonClicked(at index: IndexPath) {
        if let assignments = assignments {
            if let link = assignments[index.row].url {
                let svc = SFSafariViewController(url: URL(string: link)!)
                present(svc, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let assignments = assignments {
            return assignments.count
        }
        else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentTableViewCell", for: indexPath)
        // cell.selectionStyle = .none
        
        if let assignmentCell = cell as? AssignmentTableViewCell {
            if assignmentCell.delegate == nil {
                assignmentCell.delegate = self
            }
            if let assignments = assignments {
                /*
                 guard (assignments[indexPath.row].score?.characters.count)! < 3 else {
                 assignmentCell.assignmentNameLabel.text = "\(assignments[indexPath.row].assignmentTitle) due in"
                 assignmentCell.gradeLabel.font = UIFont(name: "Avenir-Black", size: 20)
                 assignmentCell.gradeLabel.layer.shadowColor = UIColor.clear.cgColor
                 assignmentCell.gradeLabel.text = assignments[indexPath.row].score
                 assignmentCell.topHorizontalRule.isHidden = true
                 assignmentCell.bottomHorizontalRule.isHidden = true
                 //assignmentCell.repoLink.isHidden = true
                 return cell
                 }
                 */
                let assignment = assignments[indexPath.row]
                assignmentCell.assignmentNameLabel.text = assignment.assignmentTitle
                assignmentCell.gradeLabel.text = convertDateToString(assignment.date)
                //                assignmentCell.assignmentNameLabel.text = assignments[indexPath.row].assignmentTitle
                //                  assignmentCell.dateLabel.text = assignments[indexPath.row].date
                guard assignments[indexPath.row].url != nil else {
                    //                    assignmentCell.repoLink.isHidden = true
                    return cell
                }
                //assignmentCell.repoLink.setTitle("Link to Repo", for: .normal)
                
            }
        }
        
        return cell
    }
    
    func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        return dateFormatter.string(from: date)
    }
    
    // Button
    
    lazy var logOutButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Log Out".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    
    // MARK: - Button Action
    
    func logOutButtonWasPressed(selector: UIButton) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                self.navigationController?.navigationBar.isHidden = true
                selector.isHidden = true
                self.dismiss(animated: true, completion: nil)
                
            }
            catch {
                print(error)
            }
        }
        
    }
}
