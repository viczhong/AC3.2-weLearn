//
//  LinksTableViewController.swift
//  weLearn
//
//  Created by Karen Fuentes on 3/9/17.
//  Copyright © 2017 Victor Zhong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SafariServices

class LinkTableViewController: UITableViewController, Tappable {
    
    let databaseReference = FIRDatabase.database().reference()
    var links: [Link]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Links"
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        tableView.separatorStyle = .none

        
        self.getDataInfo()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getDataInfo() {
        
        databaseReference.child("Links").child(User.manager.classroom!).observeSingleEvent(of: .value, with: { (snapShot) in
            guard let value = snapShot.value as? [String : Any] else { return }
            var linksArr = [Link]()
            for link in value {
                guard let dict = link.value as? [String : Any] else { return }
                guard let links = Link(fromDict: dict) else { return }
                linksArr.append(links)
            }
            self.links = linksArr
            self.tableView.reloadData()
            print(">>> there are \(self.links.count) links")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Button stuff
    
    func cellTapped(cell: UITableViewCell) {
        self.urlButtonClicked(at: tableView.indexPath(for: cell)!)
    }
    
    func urlButtonClicked(at index: IndexPath) {
        let svc = SFSafariViewController(url: URL(string: links[index.row].url)!)
        present(svc, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as! LinkTableViewCell
        // cell.selectionStyle = .none
        
        if cell.delegate == nil {
            cell.delegate = self
        }
        
        cell.selectionStyle = .blue
        
        cell.authorLabel.text = "\(links[indexPath.row].author):"
        cell.descriptionLabel.text = links[indexPath.row].description
        // cell.author.text = announcements![indexPath.row].author
        guard links[indexPath.row].url != nil else {
            cell.urlButton.isHidden = true
            return cell
        }
    
        return cell
    }
}
