//
//  VCDeals.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCDeals: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataStore = DealsData()
    var myPostRequest = DealsPostRequest()
    @IBOutlet weak var TvDealsOutlet: UITableView!

    let myCell = "dealsPrototype"

    @IBOutlet weak var cellOutlet: DealsCustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Deals")
        
        // Setup delegate / datasource
        TvDealsOutlet.delegate = self
        TvDealsOutlet.dataSource = self
        
        myPostRequest.dealsPostRequest(VCDeals: self, city: "KBOS")
        
        // Setup the auto sizing of the cells
        TvDealsOutlet.rowHeight = UITableViewAutomaticDimension
        TvDealsOutlet.estimatedRowHeight = 140

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return dataStore.getDeals().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath) as! DealsCustomCell
        
        //cell.leftlabel?.text = "Picture Here"
        cell.dealsLabel?.text = dataStore.getDeals()[indexPath.row]
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ TVFriendsOutlet: UITableView,
                   numberOfRowsInSection: Int) -> Int {
        return dataStore.getDeals().count
    }
    
    func updateTableView(myNewDataSet: [String]){
        print(self.dataStore.changeData(myArray: myNewDataSet))
        DispatchQueue.main.async { [unowned self] in
            self.TvDealsOutlet.reloadData()
        }
    }
    
    func getDataStore() -> DealsData{
        return self.dataStore
    }
    
    func notify( sendIt: inout [String]){
        print("Result",sendIt)
        
        updateTableView(myNewDataSet :sendIt)
    }

    
    
}
