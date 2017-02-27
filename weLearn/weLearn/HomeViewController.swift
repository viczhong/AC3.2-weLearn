//
//  HomeViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        viewHiearchy()
        configureConstraints()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "agendaCell")
        
        announcementButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        homeworkButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        LinksButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
    }
    
    func viewHiearchy() {
        self.view.addSubview(tableview)
        self.view.addSubview(LinksButton)
        self.view.addSubview(homeworkButton)
        self.view.addSubview(announcementButton)
        
    }
    func configureConstraints(){
        
        self.edgesForExtendedLayout = []
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        announcementButton.translatesAutoresizingMaskIntoConstraints = false
        homeworkButton.translatesAutoresizingMaskIntoConstraints = false
        LinksButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
        
        announcementButton.topAnchor.constraint(equalTo: tableview.bottomAnchor, constant: 16.0).isActive = true
        announcementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        homeworkButton.topAnchor.constraint(equalTo: announcementButton.bottomAnchor, constant: 8.0).isActive = true
        homeworkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        LinksButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LinksButton.topAnchor.constraint(equalTo: homeworkButton.bottomAnchor, constant: 8.0).isActive = true
    }
    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath)
        cell.textLabel?.text = "DO THIS YOU LAZY FUCK"
        cell.backgroundColor = .white
        return cell
    }
    
    // MARK: - Button Functions
    
    func buttonWasPressed(button: UIButton) {
        switch button {
        case announcementButton:
            navigationController?.pushViewController(OldAnnouncementsTableViewController(), animated: true)
        case homeworkButton:
            navigationController?.pushViewController(HomeworkTableViewController(), animated: true)
        case LinksButton:
            navigationController?.pushViewController(LinksCollectionViewController(), animated: true)
            
        default:
            print("IDK BRUH")
            
        }
    }
    
    // MARK: - UI Elements
    
    lazy var announcementButton: UIButton = {
        let button = UIButton()
        button.setTitle("ANNOUNCEMENT", for: .normal)
        //button.addTarget(self, action: #selector(buttonWasPressed(button: button)), for: .touchUpInside)
        return button
    }()
    lazy var LinksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Links", for: .normal)
        return button
    }()
    lazy var homeworkButton: UIButton = {
        let button = UIButton()
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
