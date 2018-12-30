//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Meheboob MacBook on 12/23/18.
//  Copyright © 2018 Suveechi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        self.tableView.dataSource = self
    }

    
    
    let dispatchGroup = DispatchGroup()
    
    func run(after seconds : Int, completion : @escaping () -> Void)  {
        
        
        let deadline = DispatchTime.now() + .seconds(seconds)
        
        DispatchQueue.main.asyncAfter(deadline: deadline){
            
            completion()
        }
        
    }
    
    let groupA = ["User 1", "User 2"]
    let groupB = ["User 3", "User 4"]
    let groupC = ["User 5", "User 6"]
    
    
    var users = [String]()
    
    
    func getGroupA()  {
        
        
        dispatchGroup.enter()
        
        run(after: 2) {
            print("Got A")
            
            self.users.append(contentsOf: self.groupA)
            self.dispatchGroup.leave()
        }
        
       
    }
    
    func getGroupB()  {
         print("Got B")
        
        dispatchGroup.enter()
        
        run(after: 4) {
             self.users.append(contentsOf: self.groupB)
            
            self.dispatchGroup.leave()
        }
        
    }
    
    func getGroupC()  {
         print("Got C")
        
        dispatchGroup.enter()
        run(after: 6) {
            self.users.append(contentsOf: self.groupC)
            self.dispatchGroup.leave()
        }
        
    }
    
    
    
    func displayUsers() {
        print("Reloading data")
        
        self.tableView.reloadData()
    }
    
    @IBAction func download(_ sender: Any) {
        print("Downloading...")
        
        getGroupA()
        getGroupB()
        getGroupC()
        
        
        
        dispatchGroup.notify(queue: .main){
            
            self.displayUsers()
        }
        
      
    }
    
    
    
}




extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row]
        return cell
        
    }
    
    
    
}
