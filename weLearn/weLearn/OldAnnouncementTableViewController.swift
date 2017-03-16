//
//  OldAnnouncementTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 2/27/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class OldAnnouncementsTableViewController: UITableViewController {
    
    fileprivate let reuseIdentifier = "AnnouncementCell"
    
    var announcements: [Announcement]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        announcements = [
            Announcement(quote: "You all got A's! Wow!", author: "Ben"),
            Announcement(quote: "TGIF", author: "Jason"),
            Announcement(quote: "Human beings evolved from a common ancestor of the chimpanzee.", author: "Darwin"),
            Announcement(quote: "I love cats", author: "Louis"),
            Announcement(quote: "We bought a fridge", author: "Rina"),
            Announcement(quote: "Hacked!", author: "Evan")
        ]
        
        self.navigationItem.title = "Announcements"
        self.tabBarController?.title = navigationItem.title
        
       // navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
       // linksButton.addTarget(self, action: #selector(buttonWasPressed(button:)), for: .touchUpInside)
       // let rightButton = UIBarButtonItem(customView: linksButton)
       // navigationItem.setRightBarButton(rightButton, animated: true)
        
        tableView.register(AnnouncementTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        tableView.separatorStyle = .none

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Actions
    
//    func buttonWasPressed(button: UIButton) {
//        //    navigationController?.pushViewController(LinksCollectionViewController(), animated: true)
//    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return announcements?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementTableViewCell
        cell.selectionStyle = .none
        // Configure the cell...
        
        cell.date.text = announcements![indexPath.row].date
        cell.quote.text = announcements![indexPath.row].quote
        cell.author.text = announcements![indexPath.row].author
        
        cell.bar.isHidden = true
        
        return cell
    }
    
 }
