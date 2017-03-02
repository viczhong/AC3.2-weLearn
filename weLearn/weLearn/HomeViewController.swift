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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
        viewHiearchy()
        configureConstraints()
        
        linksButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: linksButton)
        navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    
    
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
    
    // MARK: - TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
            
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: announcementCellID, for: indexPath)
            if let firstCell = cell as? AnnouncementTableViewCell {
                firstCell.label.text = "This is one of your announcements"
            }
            
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
    
    lazy var linksButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Links", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
}
