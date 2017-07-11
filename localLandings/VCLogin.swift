//
//  Login.swift
//  localLandings
//
//  Created by Jeff Frabell on 6/15/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Login")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func click(_ sender: UIButton) {
        print("Clicked!")

        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Main")
        self.show(vc as! UIViewController, sender: vc)

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
