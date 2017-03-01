//
//  HomeViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let currentDate = Date()
    let calendar = Calendar.current
    let agendaSheetID = "1o2OX0aweZIEiIgZNclasDH3CNYAX_doBNweP59cvfx4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHiearchy()
        configureConstraints()
        readAgenda()
        
        let dateInTitle = DateFormatter()
        dateInTitle.dateFormat = "E, MMM dd"
        
        self.title = dateInTitle.string(from: currentDate)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "agendaCell")
        
        announcementButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        homeworkButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        linksButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
    }
    
    
    // MARK: - Layout Setup
    func viewHiearchy() {
        self.view.addSubview(tableview)
        self.view.addSubview(linksButton)
        self.view.addSubview(homeworkButton)
        self.view.addSubview(announcementButton)
    }
    
    func configureConstraints(){
        
        self.edgesForExtendedLayout = []
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        announcementButton.translatesAutoresizingMaskIntoConstraints = false
        homeworkButton.translatesAutoresizingMaskIntoConstraints = false
        linksButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
        
        announcementButton.topAnchor.constraint(equalTo: tableview.bottomAnchor, constant: 16.0).isActive = true
        announcementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        announcementButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        homeworkButton.topAnchor.constraint(equalTo: announcementButton.bottomAnchor, constant: 8.0).isActive = true
        homeworkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeworkButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        linksButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linksButton.topAnchor.constraint(equalTo: homeworkButton.bottomAnchor, constant: 8.0).isActive = true
        linksButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    // MARK: - Functions and Methods
    
    func readAgenda() {
        APIRequestManager.manager.getData(endPoint: "https://spreadsheets.google.com/feeds/list/\(agendaSheetID)/od6/public/basic?alt=json") { (data: Data?) in
            if let returnedData = data {
                dump(returnedData)
            }
        }
    }
    
    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath)
        cell.textLabel?.text = "DO THIS YOU LAZY FUCK"
        return cell
    }
    
    // MARK: - Button Functions
    
    func buttonWasPressed(button: UIButton) {
        switch button {
        case announcementButton:
            navigationController?.pushViewController(OldAnnouncementsTableViewController(), animated: true)
        case homeworkButton:
            navigationController?.pushViewController(HomeworkTableViewController(), animated: true)
        case linksButton:
            navigationController?.pushViewController(LinksCollectionViewController(), animated: true)
        default:
            print("IDK BRUH")
            
        }
    }
    
    // MARK: - UI Elements
    
    lazy var announcementButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Announcements", for: .normal)
        //button.addTarget(self, action: #selector(buttonWasPressed(button: button)), for: .touchUpInside)
        return button
    }()
    
    lazy var linksButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Links", for: .normal)
        return button
    }()
    
    lazy var homeworkButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Homework", for: .normal)
        return button
    }()
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
}
