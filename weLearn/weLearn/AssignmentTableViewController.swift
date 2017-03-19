//
//  AssignmentTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import AudioToolbox
import SafariServices
import FirebaseAuth
import Firebase

class AssignmentTableViewController: UITableViewController, SFSafariViewControllerDelegate, Tappable {
    
    var assignments: [Assignment]? {
        didSet {
            User.setAssignmentsReversed(assignments)
        }
    }
    
    var gradesParsed: [(assignment: String, grade: String)] = [] {
        didSet {
            User.manager.assignmentGrades = gradesParsed.reversed()
        }
    }
    
    let assignmentSheetID = MyClass.manager.assignmentsID!
    let gradeBookSheetID = MyClass.manager.gradeBookID!
    var assignmentGrades: AssignmentGrade?
    var databaseReference: FIRDatabaseReference!
    
    var stopTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Assignments"
        self.tabBarController?.title = navigationItem.title
        
        databaseReference = FIRDatabase.database().reference()
        
        tableView.register(AssignmentTableViewCell.self, forCellReuseIdentifier: "AssignmentTableViewCell")
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.snp.makeConstraints { view in
            view.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if assignments == nil {
            readAssignments()
            startGrabbingAssignmentsData()
        }
    }
    
    func startGrabbingAssignmentsData() {
        if User.manager.assignmentGrades == nil {
            APIRequestManager.manager.getData(endPoint: "https://spreadsheets.google.com/feeds/list/\(gradeBookSheetID)/od6/public/basic?alt=json") { (data: Data?) in
                if data != nil {
                    self.fetchStudentAssignmentData(data!)
                }
            }
        }
    }
    
    func fetchStudentAssignmentData(_ data: Data) {
        
        // Now that we have the number, grab that person's grades
        if let studentID = User.manager.id {
            if let returnedGradesData = AssignmentGrade.getStudentAssignmentGrade(from: data, for: studentID) {
                print("\n\n\nWe've got grades for: \(returnedGradesData.id)")
                
                self.assignmentGrades = returnedGradesData
                self.gradesParsed = AssignmentGrade.parseGradeString(self.assignmentGrades!.grades)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func readAssignments() {
        self.view.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
        
        if User.manager.assignments == nil {
            APIRequestManager.manager.getData(endPoint: "https://spreadsheets.google.com/feeds/list/\(assignmentSheetID)/od6/public/basic?alt=json") { (data: Data?) in
                if data != nil {
                    if let returnedAssignments = Assignment.getAssignment(from: data!) {
                        print("We've got returns: \(returnedAssignments.count)")
                        self.assignments = returnedAssignments
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        } else {
            print("error loading data!")
            self.activityIndicator.stopAnimating()
        }
    }
    
    func cellTapped(cell: UITableViewCell) {
        self.repoButtonClicked(at: tableView.indexPath(for: cell)!)
    }
    
    func repoButtonClicked(at index: IndexPath) {
        let currentCell = tableView.cellForRow(at: index) as! AssignmentTableViewCell
        
        UIView.animate(withDuration: 0.5, animations: {
            currentCell.box.layer.shadowOpacity = 0.1
            currentCell.box.layer.shadowRadius = 1
            currentCell.box.apply(gradient: [UIColor.weLearnGrey.withAlphaComponent(0.1), UIColor.weLearnGrey.withAlphaComponent(0.1), UIColor.weLearnCoolWhite])
        }, completion: { finish in
            currentCell.box.layer.shadowOpacity = 0.25
            currentCell.box.layer.shadowRadius = 2
            currentCell.box.layer.sublayers!.remove(at: 0)
        })
        
        if let assignments = User.manager.assignments {
            if let link = assignments[index.row].url {
                AudioServicesPlaySystemSound(1105)
                let svc = SFSafariViewController(url: URL(string: link)!)
                navigationController?.show(svc, sender: self)
                svc.delegate = self
            } else {
                AudioServicesPlaySystemSound(1103)
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
        cell.selectionStyle = .none
        
        if let assignmentCell = cell as? AssignmentTableViewCell {
            if assignmentCell.delegate == nil {
                assignmentCell.delegate = self
            }
            if let assignments = User.manager.assignments {
                let assignment = assignments[indexPath.row]
                let endTime = assignment.date
                let difference = endTime.timeIntervalSinceNow
                
                if difference < 0 {
                    assignmentCell.assignmentNameLabel.text = assignment.assignmentTitle
                    assignmentCell.optionalTimerLabel.isHidden = true
                    assignmentCell.optionalTimerLabelsShadow.isHidden = true
                    if let gradeAtRow = User.manager.assignmentGrades {
                        assignmentCell.assignmentCountDownLabel.text = "Grade: \(gradeAtRow[indexPath.row].grade)"
                    }
                } else {
                    let endTime = assignment.date
                    let difference = endTime.timeIntervalSinceNow as CFTimeInterval
                    let timeInSeconds = Int(difference)
                    
                    let days = Int(timeInSeconds) / 86400
                    let hours = Int(timeInSeconds) / 3600 % 24
                    let minutes = Int(timeInSeconds) / 60 % 60
                    let properPercentage = (CGFloat(168 - Int(timeInSeconds)/3600)/168)
                    
                    assignmentCell.optionalTimerLabel.isHidden = false
                    assignmentCell.optionalTimerLabelsShadow.isHidden = false
                    assignmentCell.optionalTimerLabel.animate(towardsDeadline: properPercentage, forDuration: 1)
                    assignmentCell.assignmentCountDownLabel.text = String(format: "%i days, %i hours, & %i minutes until ", days, hours, minutes) + "deadline"
                    assignmentCell.assignmentNameLabel.text = assignment.assignmentTitle
                }
                
                return cell
            }
        }
        
        return cell
    }
    
    func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, dd yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.hidesWhenStopped = true
        view.color = UIColor.weLearnGreen
        return view
    }()
    
}
