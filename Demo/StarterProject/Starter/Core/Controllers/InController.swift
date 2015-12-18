//
//  InController.swift
//  Starter
//
//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import UIKit

class InController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getUser() {
        ClientService.sharedInstance.getLondonWeather { (success) -> () in
            if success != nil {
                print(success!)
            }
        }
    }
    
    @IBAction func clearDefaults() {
        ClientService.sharedInstance.logoutUser()
        
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate {
            app.showOutController()
        }
    }

}
