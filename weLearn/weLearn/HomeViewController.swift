//
//  HomeViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let announcementCellID = "AnnouncemntCell"
fileprivate let agendaCellID = "AgendaCellID"
fileprivate let dueDatesCellID = "DueDatesCellID"

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let currentDate = Date()
    let calendar = Calendar.current
    let agendaSheetID = "1o2OX0aweZIEiIgZNclasDH3CNYAX_doBNweP59cvfx4"
    var agenda = [Agenda]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
        viewHiearchy()
        configureConstraints()
        readAgenda()
        
        let dateInTitle = DateFormatter()
        dateInTitle.dateFormat = "E, MMM dd"
        
        self.title = dateInTitle.string(from: currentDate)
        
        tableView.separatorStyle = .none
        
        linksButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: linksButton)
        navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    // MARK: - Layout Setup
    func viewHiearchy() {
        self.view.addSubview(tableView)
    }
    
    func configureConstraints(){
        
        self.edgesForExtendedLayout = []
        tableView.snp.makeConstraints { (tV) in
            tV.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    func registerCell() {
        tableView.register(AnnouncementTableViewCell.self, forCellReuseIdentifier: announcementCellID)
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: agendaCellID)
        tableView.register(DueDatesTableViewCell.self, forCellReuseIdentifier: dueDatesCellID)
    }
    
    // MARK: - Functions and Methods
    
    func readAgenda() {
        APIRequestManager.manager.getData(endPoint: "https://spreadsheets.google.com/feeds/list/\(agendaSheetID)/od6/public/basic?alt=json") { (data: Data?) in
            if data != nil {
                if let returnedAgenda = Agenda.getAgenda(from: data!) {
                    print("We've got contacts: \(returnedAgenda.count)")
                    self.agenda = returnedAgenda
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            //Announcement
            return 1
        case 1:
            //Agenda
            return agenda.count
        case 2:
            //DueDates
            return 1
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: announcementCellID, for: indexPath)
            if let firstCell = cell as? AnnouncementTableViewCell {
                firstCell.label.text = "This is one of your announcements"
            }
            // let agendaPost = agenda[indexPath.row]
            
            // cell.textLabel?.text = agendaPost.lessonName
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: agendaCellID, for: indexPath)
            if let secondCell = cell as? AgendaTableViewCell {
                secondCell.label.text = "This is your agenda"
            }
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: dueDatesCellID, for: indexPath)
            if let thirdCell = cell as? DueDatesTableViewCell {
                thirdCell.label.text = "This is what is due"
            }
            
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            navigationController?.pushViewController(OldAnnouncementsTableViewController(), animated: true)
        case 1: break
            //Add the viewController to be presented
        case 2: break
            //Add the viewController to be presented
        default:
            break
        }
    }
    
    
    // MARK: - Button Functions
    
    func buttonWasPressed(button: UIButton) {
//    navigationController?.pushViewController(LinksCollectionViewController(), animated: true)
    }
    
    // MARK: - UI Elements
    
    lazy var linksButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Links", for: .normal)
        button.backgroundColor = UIColor.weLearnGreen
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(#imageLiteral(resourceName: "logoForNavBarButton"), for: .normal)
        button.imageView?.contentMode = .center
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
}
