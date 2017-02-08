//
//  Friends.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class FriendsCustomCell : UITableViewCell {
    @IBOutlet weak var leftlabel: UILabel!

    @IBOutlet weak var rightlabel: UILabel!
    
    var cat = 12
}


class VCFriends: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    //MARK: Properties
    let dataStore = IceCreamStore()

    @IBOutlet weak var TVFriendsOutlet: UITableView!


    
    let myCell = "reuseme"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup delegate / datasource
        TVFriendsOutlet.delegate = self
        TVFriendsOutlet.dataSource = self
        
//        self.TVFriendsOutlet.register(FriendsCustomCell.self, forCellReuseIdentifier: myCell)

        
        var request = URLRequest(url: URL(string: "http://ll.bunnyhutt.com/friendsdummy.php")!)
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }

    //MARK: Actions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
  
    
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return dataStore.allFlavors().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath) as! FriendsCustomCell
        
        //This populates the cells
        //cell.textLabel?.text=dataStore.allFlavors()[indexPath.row]
        
        //This doesn't.
        cell.leftlabel?.text = dataStore.allFlavors()[indexPath.row]
        cell.rightlabel?.text = "You GTBSM"
        
        print("found a cell")
        return cell
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ TVFriendsOutlet: UITableView,
                   numberOfRowsInSection: Int) -> Int {
        return dataStore.allFlavors().count
    }
  
}

class IceCreamStore
{
    private let flavors = ["Vanilla", "Chocolate", "Strawberry", "Coffee", "Cookies & Cream", "Rum Raisins", "Mint Chocolate Chip", "Peanut Butter Cup"]
    
    func allFlavors() -> [String]
    {
        return flavors
    }
}



