//
//  navigationViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class navigationViewController: UINavigationController {
    var companyInfo :CompanyApp!
    var aboutInfo:Facade!
    var stb : UIStoryboard!
    var titleView : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let color = self.companyInfo.palette as ColorPalette
        
        navigationBar.translucent = false
        navigationBar.barTintColor = UIColor (rgba: color.color1 as String)
        navigationBar.tintColor = UIColor (rgba: color.color3 as String)
        
        //meetings
        let meetingsVC = stb.instantiateViewControllerWithIdentifier("meetingView") as! meetingsViewController
        meetingsVC.meetingApps = self.companyInfo
        meetingsVC.titleView = titleView
      
        //staff
        let staffVC = stb.instantiateViewControllerWithIdentifier("staffView") as! StaffViewController
        staffVC.staffInfo = self.companyInfo
        staffVC.titleView = titleView
        
        //Company
        let companyVC = stb.instantiateViewControllerWithIdentifier("companyView") as! companyViewController
        companyVC.companyInfo = companyInfo
        companyVC.companyAboutInfo = self.companyInfo.companies.firstObject as! Facade
        companyVC.titleView = titleView

        //Survey
        let surveyVC = stb.instantiateViewControllerWithIdentifier("surveyView") as! surveyViewController

        //More
        let moreVC = stb.instantiateViewControllerWithIdentifier("otherView") as! othersViewController
        moreVC.companyInfo = self.companyInfo
        //moreVC.titleView = titleView

        for obje in self.companyInfo.views{
        
            if let vis = obje as? View{
            
        for sec in vis.sections{
            
            if let secti = sec as? Section{
            
                if  let faca = secti.objects.firstObject as? Facade{
                    faca.fetchFromLocalDatastoreInBackground()
                    moreVC.companyAboutInfo = faca
                
                println("jaja" + (faca.role as String))
            }}
        }}
    }
        
        if(self.tabBarItem.tag == 1){
            self.viewControllers = [meetingsVC]
        }
        else if(self.tabBarItem.tag == 2){
            self.viewControllers = [staffVC]
        }
        else if(self.tabBarItem.tag == 3){
            self.viewControllers = [companyVC]
        }
        else if(self.tabBarItem.tag == 4){
            self.viewControllers = [surveyVC]
            
        }
        else if(self.tabBarItem.tag == 5){
            self.viewControllers = [moreVC]
            
        }
    }
}
    class navigationViewControllerMeeting: UINavigationController {
        var meeting :MeetingApp!
        var urlTrip : String!
        var titleView : String!
        var titleView2 : String!

        var stb : UIStoryboard!
        var arra = NSArray()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let color = self.meeting.palette as ColorPalette
            navigationBar.translucent = false
            navigationBar.barTintColor = UIColor (rgba: color.color1 as String)
            navigationBar.tintColor = UIColor (rgba: color.color3 as String)
            
            self.funcionete()
        }
        
        override func viewWillAppear(animated: Bool) {
         
            self.funcionete()
            
        }
        
        func funcionete() {
            
            let eventVC = stb.instantiateViewControllerWithIdentifier("eventosViewController") as! eventosViewController
            eventVC.eventos = self.meeting
            eventVC.titleView1 = titleView
            eventVC.titleView2 = titleView2
            
            let expoVC = stb.instantiateViewControllerWithIdentifier("expositoresViewController") as! expositoresViewController
            expoVC.meetingExpositores = self.meeting
            expoVC.titleView = titleView
            
            let sponsorsVC = stb.instantiateViewControllerWithIdentifier("sponsorsViewController") as! sponsorsViewController
            sponsorsVC.meetingSponsors = self.meeting
            sponsorsVC.titleView = titleView
            
            let favoritosVC = stb.instantiateViewControllerWithIdentifier("favoritosViewController") as! favoritosViewController
            favoritosVC.meetingFav = self.meeting
            favoritosVC.titleView = titleView
           
            let libraryVC = stb.instantiateViewControllerWithIdentifier("libraryViewController") as! libraryViewController
            libraryVC.meetingLibrary = self.meeting.library
            libraryVC.titleView = titleView
            
            let galleryVC = stb.instantiateViewControllerWithIdentifier("galleryViewController") as! galleryViewController
            galleryVC.meetingGallery = self.meeting
            galleryVC.titleView = titleView
            
            let tripVC = stb.instantiateViewControllerWithIdentifier("tripViewController") as! tripViewController
            tripVC.meetingApp = self.meeting
            tripVC.urlPath2 = self.urlTrip
            

            if(self.tabBarItem.tag == 1){
                self.viewControllers = [eventVC]
            }
            else if(self.tabBarItem.tag == 2){
                self.viewControllers = [expoVC]
            }
            else if(self.tabBarItem.tag == 3){
                self.viewControllers = [sponsorsVC]
            }
            else if(self.tabBarItem.tag == 4){
                self.viewControllers = [favoritosVC]
            }
            else if(self.tabBarItem.tag == 5){
                self.viewControllers = [libraryVC]
            }
            else if(self.tabBarItem.tag == 6){
                self.viewControllers = [galleryVC]
            }
            else if(self.tabBarItem.tag == 7){
                self.viewControllers = [tripVC]
            }

        }

}