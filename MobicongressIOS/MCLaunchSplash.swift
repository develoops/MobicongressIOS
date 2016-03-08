//
//  MCLaunchViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MCLaunchViewController: UIViewController,UIAlertViewDelegate {
  
    @IBOutlet var imagen: UIImageView!
    var companyApp:CompanyApp!
    var splashIma = UIImageView()
    var progress:UIProgressView!
    var label:UILabel!
    let device = Device()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashIma = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        progress = UIProgressView (frame: CGRect(x: self.view.frame.width * 0.2, y: self.view.frame.height - 110, width: self.view.frame.width * 0.6, height: 20))
        
        progress.setProgress(0.1, animated: true)
        label = UILabel(frame: CGRect(x: 0, y: self.view.frame.height - 130, width: self.view.frame.width, height: 20))
        label.textAlignment = NSTextAlignment.Center
        label.text = ""
        label.font = UIFont(name: "ArialMT", size: 13)
        label.textColor = UIColor .whiteColor()
        
        //ss
//        if(NSUserDefaults.standardUserDefaults().integerForKey("lanza") == 1){
        
        if device == .iPad2 || device == .iPad3 || device == .iPad4 || device == .iPadAir || device == .iPadAir || device == .iPadAir2 || device == .iPadMini || device == .iPadMini2 || device == .iPadMini3{
            
            splashIma.image = UIImage (named:"splash4")
            
        }
        
        if device == .iPhone6Plus || device == .iPhone6sPlus {

            splashIma.image = UIImage (named:"splash55")
            
        }
        
        if device == .iPhone6 || device == .iPhone6s {
            
            splashIma.image = UIImage (named:"splash47")
            
        }
        
        if device == .iPhone5s || device == .iPhone5c || device == .iPhone5 {
            
            splashIma.image = UIImage (named:"splash4")
            
        }
        
        if device == .iPhone4s {
            
            splashIma.image = UIImage (named:"splash35")
            
        }
        
        if device == .Simulator {
            
            splashIma.image = UIImage (named:"splash47")
            
        }
        
        
//        }else{
//            let cgsi = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)
//            self.splashIma.image = self.getImageWithColor(UIColor.blackColor(), size: cgsi)
//
//        }
        
        view.addSubview(splashIma)
        view.insertSubview(label, aboveSubview: splashIma)
        view.insertSubview(progress, aboveSubview: splashIma)
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("local") != true) && (Reachability.reachabilityForInternetConnection().currentReachabilityString == "No Connection")
        {
            let alertView = UIAlertView(title: "Lo siento", message: "Conéctate al menos una vez para lograr acceder al contenido de la aplicación, esta acción se realizará sólo una vez", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
        }
        else if (NSUserDefaults.standardUserDefaults().boolForKey("local") == true) && (Reachability.reachabilityForInternetConnection().currentReachabilityString == "No Connection"){
            
            self.label.text = "Sin conexíon"
            self.cargaLocal()
        println("sin connection, con carga locale")
      }
        else{
        println("con connection")
        }
        self.progress.setProgress(0.5, animated: true)
        self.label.text = "Con conexión"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cargaLocal", name:"listo", object: nil)
        
        println ("cargaLocal-Listo")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cargaLocal", name:"recarga", object: nil)
        
        println ("cargaLocal-recarga")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pic", name:"sigue", object: nil)
        
        println ("cargaLocal-sigue")
        
        self.progress.setProgress(0.95, animated: true)
        self.label.text = "Loading..."
        
        if(NSUserDefaults.standardUserDefaults().integerForKey("lanza")>1){
            
            self.cargaLocal()
        }
    }

    
    func pic(){
        self.cargaTabDirectorio()
}
    
    func cargaLocal(){
        let defolto = NSUserDefaults.standardUserDefaults()
        let query = CompanyApp.query()
        query!.limit = 1000
        query!.fromLocalDatastore()
        
        query!.includeKey("hostedCompany")
        query!.includeKey("companies")
        query!.includeKey("palette")
        query!.includeKey("meetingApps")
        query!.includeKey("meetingApps.events")
        query!.includeKey("meetingApps.walls")
      //  query!.includeKey("meetingApps.library")
        //query!.includeKey("meetingApps.gallery")
        query!.includeKey("meetingApps.place")
//        query!.includeKey("meetingApps.venues")
        query!.includeKey("meetingApps.views")
        query!.includeKey("meetingApps.companies")
        query!.includeKey("meetingApps.companies.company")
        query!.includeKey("meetingApps.companies.company.logo")
        query!.includeKey("meetingApps.palette")
        query!.includeKey("meetingApps.events.view.toolBar")
        query!.includeKey("meetingApps.events.palette")
        query!.includeKey("meetingApps.events.place")
        query!.includeKey("meetingApps.events.library")
        query!.includeKey("meetingApps.persons")
        
        // ARREGLAR!
        
       // query!.includeKey("meetingApps.persons.actors")
        
        //
        
        query!.includeKey("meetingApps.events.actors.person")
        query!.includeKey("companySplash")
        query!.includeKey("logo")
        query!.includeKey("views")
        query!.includeKey("views.sections")

        query!.findObjectsInBackground().continueWithBlock({
            (task: BFTask!) -> AnyObject! in
            if task.error != nil {

                println(task.error)
                
                return task
        }
            if(task.result.count != 0){
                
                
                self.companyApp =  task.result.firstObject as! CompanyApp
                
                NSNotificationCenter.defaultCenter().postNotificationName("sigue", object: nil)
            }
            else{
                NSNotificationCenter.defaultCenter().postNotificationName("recarga", object: nil)
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "local")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            return task
            
        })}
    
    func cargaTabDirectorio() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let meetingBarController = storyboard.instantiateViewControllerWithIdentifier("tabMeeting")as! MCTabBarViewController
        meetingBarController.companyApp = self.companyApp
        
        meetingBarController.mostrarSplash = true

        meetingBarController.stb = storyboard
        presentViewController(meetingBarController, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        var rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

