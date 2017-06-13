//
//  UtilityViewController.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/9/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class UtilityViewController: UIViewController {
    //queue is used for all dispatch controller stuff
    let queue = DispatchQueue(label: "com.bunnyhutt.myqueue")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        queue.sync {
            for i in 0..<10{
                print("Red dot ",i)
            }
        }
        
        for i in 100..<110 {
            print("Blue M ",i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
