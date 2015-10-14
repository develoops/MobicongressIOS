//
//  filesViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 09-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class filesViewController: UIViewController ,UIWebViewDelegate {

    var webV = UIWebView()
    var urling: NSString!
    var holderView = HolderView(frame: CGRectZero)
    var view2 = UIView()
    var fondoColor = UIColor()
    var label = UILabel()
    var texto: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHolderView()
        
        tabBarController?.tabBar.hidden = true

    
        view2.frame = CGRectMake(0, 0, self.view.layer.frame.width, self.view.layer.frame.height - 64)
        view2.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(view2)
        
        var request = NSURLRequest(URL: NSURL(string: self.urling as! String)!)
        webV.loadRequest(request)
        webV.frame = CGRectMake(0, 0, self.view.layer.frame.width, self.view.layer.frame.height - 64)
        webV.scalesPageToFit = true
        webV.delegate = self
        
    }
    
    func webViewDidStartLoad(webV: UIWebView) { //start
        
    }
    
    func webViewDidFinishLoad(webV: UIWebView) { //stop
        self.view.addSubview(self.webV)
        holderView.removeFromSuperview()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0

        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
            y: view.bounds.height / 2 - boxSize / 2,
            width: boxSize,
            height: boxSize)
        label.frame = (CGRect(x: 0, y: holderView.frame.origin.y + 110, width: view.bounds.width, height: 40))
        label.numberOfLines = 0
        label.textColor = UIColor .darkGrayColor()
        label.font = UIFont(name: "ArialMT", size: 11)
        
        if !(texto == "") {
        
            label.text = texto
            
        } else {
            
            label.text = "Cargando"
        }
        
        label.textAlignment = NSTextAlignment.Center
        
        view2.addSubview(label)
        
        holderView.parentFrame = view.frame
        view2.addSubview(holderView)
        holderView.addOval()
    }
    
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
