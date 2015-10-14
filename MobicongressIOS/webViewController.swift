//
//  webViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 4/17/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class webViewController: UIViewController {
    
    var stringURL:NSString!
    var webViewer:UIWebView!
    
    override func viewWillAppear(animated: Bool) {
        
        tabBarController?.tabBar.hidden = true
        
        webViewer = UIWebView(frame: CGRectMake(0, 0, self.view.layer.frame.width, self.view.layer.frame.height - 44))
        
        view.backgroundColor = UIColor .whiteColor()
        webViewer.backgroundColor = UIColor .whiteColor()
        
        let url = stringURL
        
        let requestURL = NSURL(string:url as String)
        let request = NSURLRequest(URL: requestURL!)
        webViewer.loadRequest(request)
        
        self.view.addSubview(webViewer)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }
    
}