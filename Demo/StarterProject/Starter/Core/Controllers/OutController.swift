//
//  OutController.swift
//  Starter
//
//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import UIKit

class OutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login() {
        ClientService.sharedInstance.loginUser("mark@3advance.com", password: "Therock5") { (success) -> () in
            if success != nil {
                print(Mapper().toJSONString(success!, prettyPrint: true)!)
                if let app = UIApplication.sharedApplication().delegate as? AppDelegate {
                    app.showInController()
                }
            }
        }
    }

}
