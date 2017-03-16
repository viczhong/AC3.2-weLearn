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
        
        self.navigationItem.title = "Links"
        self.tabBarController?.title = navigationItem.title
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 268.0
        
        tableView.separatorStyle = .none

        let rightButton = UIBarButtonItem(customView: logOutButton)
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        logOutButton.addTarget(self, action: #selector(logOutButtonWasPressed(selector:)), for: .touchUpInside)
        
        self.getDataInfo()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.getDataInfo()
    }
    
   func getDataInfo() {
//        
        databaseReference.child("links").child(User.manager.classDatabaseKey!).observeSingleEvent(of: .value, with: { (snapShot) in
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
        
        cell.authorLabel.text = "\(links[indexPath.row].author):"
        cell.descriptionLabel.text = links[indexPath.row].description
    
        return cell
    }
    
    lazy var logOutButton: ShinyOvalButton = {
        let button = ShinyOvalButton()
        button.setTitle("Log Out".uppercased(), for: .normal)
        button.setTitleColor(UIColor.weLearnBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        button.imageView?.clipsToBounds = true
        return button
    }()
}
