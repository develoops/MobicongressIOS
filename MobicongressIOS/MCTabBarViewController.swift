//
//  MCTabBarViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.

import UIKit

class MCTabBarViewController: UITabBarController,UITabBarControllerDelegate {
    
    var companyApp : CompanyApp!
    var stb : UIStoryboard!
    var splashIma = UIImageView()
    var mostrarSplash:Bool!
    let device = Device()
    
    func esconderSplash() {
        
        splashIma.hidden = true
        splashIma.removeFromSuperview()
        mostrarSplash = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        if (mostrarSplash == true) {
//        
//            splashIma = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
//        
//            let meetSplash = companyApp.companySplash as MobiFile
//            meetSplash.fetchFromLocalDatastoreInBackground()
//            
//            if(meetSplash.isDataAvailable()){
//                
//                var ima = PFFile()
//                let device = Device()
//            
//                if device == .iPhone4s || device == .iPhone4 {
//                    ima = companyApp.companySplash.parseFileV2
//                } else {
//                    ima = companyApp.companySplash.parseFileV1
//                }
//                
//            ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
//                
//                if(error != nil){
//                    println(error)
//                } else {
//                
//                    let image = UIImage(data:dataImagen!)
//                    self.splashIma.image = image
//                    
//                    var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("esconderSplash"), userInfo: nil, repeats: false)
//                }
//                
//            })
//            }
//            
//           // view.addSubview(splashIma)
//            
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    override func viewDidAppear(animated: Bool) {
        self.configVistas()
        let color = self.companyApp.palette as ColorPalette
        color.fetchFromLocalDatastoreInBackground()
        tabBar.translucent = false
        tabBar.barTintColor = UIColor (rgba: color.color1 as String)
        tabBar.tintColor = UIColor (rgba: color.color3 as String)

    }
    
    func configVistas(){
        var mutuViewControllers = NSMutableArray()
        
        for objetoView in companyApp.views{
            println(objetoView)
            let vis = objetoView as! View
            println(vis)
            vis.fetchFromLocalDatastoreInBackground()
            
            if(vis.nameView == "navMeeting"){
                let tabMeeting = stb.instantiateViewControllerWithIdentifier(vis.nameView as String) as! navigationViewController
                tabMeeting.stb = self.stb
                tabMeeting.companyInfo = self.companyApp
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vis.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vis.textTab as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vis.textTab as String
                    
                }
                    
                else{
                    
                    textoTab = vis.textTab as String
                    
                }
                
                tabMeeting.titleView = textoTab
                
                if (vis.icon.isDataAvailable) {
                    tabMeeting.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(data: vis.icon.getData()!,scale:2.0), tag: 1)
                } else {
                    tabMeeting.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(named: "directorio"), tag: 1)
                }
                
                mutuViewControllers.addObject(tabMeeting)
            }
                
            else if (vis.nameView == "navStaff"){
                let tabStaff = stb.instantiateViewControllerWithIdentifier(vis.nameView as String) as! navigationViewController
                tabStaff.companyInfo = self.companyApp
                tabStaff.stb = self.stb
                
                var textoTab = "" as String

                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vis.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vis.textTab as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vis.textTab as String
                    
                }
                    
                else{
                    
                    textoTab = vis.textTab as String
                    
                }
                
                tabStaff.titleView = textoTab
                
                if (vis.icon.isDataAvailable) {
                    
                    tabStaff.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(data: vis.icon.getData()!,scale:2.0), tag: 2)
                    
                    
                } else {
                                    
                    tabStaff.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(named: "directiva"), tag: 2)
                }
                
                mutuViewControllers.addObject(tabStaff)
            }
            else if (vis.nameView == "navCompany"){
                
                let tabCompany = stb.instantiateViewControllerWithIdentifier(vis.nameView as String) as! navigationViewController
                tabCompany.companyInfo = self.companyApp
                tabCompany.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vis.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vis.textTab as String
                    
                }
                else if(idioma == "pt"){
                    
                    textoTab = vis.textTab as String
                    
                }
                    
                else{
                    
                    textoTab = vis.textTab as String
                    
                }
                
                tabCompany.titleView = textoTab
                
                if (vis.icon.isDataAvailable) {
                    tabCompany.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(data: vis.icon.getData()!,scale:2.0), tag: 3)
                    
                } else {
                    tabCompany.tabBarItem = UITabBarItem(title:textoTab as String, image: UIImage(named: "quienesSomos"), tag: 3)
                }
                
                mutuViewControllers.addObject(tabCompany)
            }
                //pendiente
            else if (vis.nameView == "navOther"){
                let tabOtro = stb.instantiateViewControllerWithIdentifier(vis.nameView as String) as! navigationViewController
                tabOtro.stb = self.stb
                tabOtro.companyInfo = self.companyApp
                
                if (vis.icon.isDataAvailable) {
                    tabOtro.tabBarItem = UITabBarItem(title:vis.textTab as String, image: UIImage(data: vis.icon.getData()!,scale:2.0), tag: 4)
                } else {
                    tabOtro.tabBarItem = UITabBarItem(title:vis.textTab as String, image: UIImage(named: "quienesSomos"), tag: 4)
                }
                
                mutuViewControllers.addObject(tabOtro)
            }}
        
        self.viewControllers = mutuViewControllers as [AnyObject]

    
    }
    
}
