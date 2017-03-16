//
//  AgendaTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 3/8/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//
import UIKit
import SafariServices
import FirebaseAuth

class AgendaTableViewController: UITableViewController {
//    var todaysFakeSchedule: [String] = [
//        "DSA",
//        "Sprite Kit with Louis",
//        "Capstone",
//        "Lunch break",
//        "Talk to Tech Mentors",
//        "Workshop at Headquarters"
//    ]
    
    let agendaSheetID = "1o2OX0aweZIEiIgZNclasDH3CNYAX_doBNweP59cvfx4"
    let assignmentSheetID = "1X0u5jM7-L4RSqdGC0AWa1XsyvSusV2wLDTtmwgBERJA"
    var todaysAgenda: Agenda?
    
    var agenda: [Agenda]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Syllabus"
        
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: "AgendaTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        let rightButton = UIBarButtonItem(customView: logOutButton)
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        logOutButton.addTarget(self, action: #selector(logOutButtonWasPressed(selector:)), for: .touchUpInside)
        
        
        readAgenda()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Agenda functions
    
    func todaysSchedule() -> Agenda? {
        if let agenda = agenda {
            LessonSchedule.manager.setAgenda(agenda)
            if let agendaception = LessonSchedule.manager.pastAgenda {
                return agendaception[0]
            }
        }
        return nil
    }
    
    func readAgenda() {
        if LessonSchedule.manager.pastAgenda == nil {
            APIRequestManager.manager.getData(endPoint: "https://spreadsheets.google.com/feeds/list/\(agendaSheetID)/od6/public/basic?alt=json") { (data: Data?) in
                if data != nil {
                    if let returnedAgenda = Agenda.getAgenda(from: data!) {
                        print("We've got returns: \(returnedAgenda.count)")
                        self.agenda = returnedAgenda
                        DispatchQueue.main.async {
                            self.todaysAgenda = self.todaysSchedule()
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        else {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Button Actions
    
    func logOutButtonWasPressed(selector: UIButton) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                self.navigationController?.navigationBar.isHidden = true
                selector.isHidden = true
                _ = self.navigationController?.popToRootViewController(animated: true)
                
            }
            catch {
                print(error)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.weLearnBlue
        header.textLabel?.font = UIFont(name: "Avenir-Light", size: 30)
        header.textLabel?.textAlignment = .center
        header.textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            //        case 0:
        //            return "March 10, 2017"
        case 0:
            if agenda != nil {
                return "Today's Schedule"
            }
            else {
                return nil
            }
            //        case 1:
            //            return "March 09, 2017"
            //        case 2:
        //            return "March 07, 2017"
        default:
            return ""
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let agenda = LessonSchedule.manager.pastAgenda {
            return agenda.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
        
        // needs diff sections
        
        if let agenda = LessonSchedule.manager.pastAgenda {
            let agendaAtRow = agenda[indexPath.row]
            cell.label.text = "\(agendaAtRow.dateString) - \(agendaAtRow.lessonName)"
        }
        return cell
    }
    
    lazy var logOutButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Log Out".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        //button.backgroundColor = UIColor.weLearnBlue
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        //button.setImage(#imageLiteral(resourceName: "logoForNavBarButton"), for: .normal)
        //button.imageView?.contentMode = .center
        button.imageView?.clipsToBounds = true
        return button
    }()
    
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
