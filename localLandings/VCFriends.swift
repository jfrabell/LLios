//
//  Friends.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCFriends: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //MARK: Properties
    var dataStore = FriendsData()
    var myPostRequest = PostRequest()
    @IBOutlet weak var TVFriendsOutlet: UITableView!
    let myCell = "reuseme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup delegate / datasource
        TVFriendsOutlet.delegate = self
        TVFriendsOutlet.dataSource = self
        
        myPostRequest.postRequest(VCFriends: self)
        
        // Setup the auto sizing of the cells
        TVFriendsOutlet.rowHeight = UITableView.automaticDimension
        TVFriendsOutlet.estimatedRowHeight = 140
        
    }

    //MARK: Actions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
  
    
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return dataStore.getPeople().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath) as! FriendsCustomCell

        //cell.leftlabel?.text = "Picture Here"
        cell.rightlabel?.text = dataStore.getPeople()[indexPath.row]
        return cell
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ TVFriendsOutlet: UITableView,
                   numberOfRowsInSection: Int) -> Int {
        return dataStore.getPeople().count
    }
    
    func updateTableView(myNewDataSet: [String]){
        print(self.dataStore.changeData(myArray: myNewDataSet))
        DispatchQueue.main.async { [unowned self] in
            self.TVFriendsOutlet.reloadData()
        }
    }
    
    func getDataStore() -> FriendsData{
        return self.dataStore
    }
    
    func notify( sendIt: inout [String]){
        print("Result",sendIt)

        updateTableView(myNewDataSet :sendIt)
    }


  
}



