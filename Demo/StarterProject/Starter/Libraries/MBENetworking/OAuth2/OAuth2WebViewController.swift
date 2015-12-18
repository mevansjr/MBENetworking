//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

import UIKit
/**
OAuth2WebViewController is a UIViewController to be used when the Oauth2 flow used an embedded view controller 
rather than an external browser approach.
*/
class OAuth2WebViewController: UIViewController, UIWebViewDelegate {
    /// Login URL for OAuth.
    var targetURL : NSURL = NSURL()
    /// WebView intance used to load login page.
    var webView : UIWebView = UIWebView()
    
    /// Overrride of viewDidLoad to load the login page.
    override internal func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = UIScreen.mainScreen().applicationFrame
        webView.delegate = self
        self.view.addSubview(webView)
        loadAddressURL()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView.frame = self.view.bounds
    }
    
    override internal func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadAddressURL() {
        let req = NSURLRequest(URL: targetURL)
        webView.loadRequest(req)
    }
}
