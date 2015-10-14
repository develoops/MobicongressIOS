//
//  MCTabBarViewControllerEventos.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 08-04-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MCTabBarViewControllerEventos: UITabBarController,UITabBarControllerDelegate {
    var meetingInfo : MeetingApp!
    var stb : UIStoryboard!
    var mutuControllers = NSMutableArray()
    var splashIma:UIImageView!
    let device = Device()
    
    func esconderSplash() {
        
        splashIma.hidden = true
        splashIma.removeFromSuperview()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("esconderSplash"), userInfo: nil, repeats: false)
        
        
        splashIma = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        let meetSplash = meetingInfo.splashMeeting as MobiFile
        meetSplash.fetchFromLocalDatastoreInBackground()
        if(meetSplash.isDataAvailable()){
            
            var ima = PFFile()
            let device = Device()
            
            if device == .iPhone4s || device == .iPhone4  || device == .Simulator {
                ima = meetSplash.parseFileV2
            } else {
                ima = meetSplash.parseFileV1
            }
            
            ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                
                if(error != nil){
                    println(error)
                }
                    
                else{
                    
                    let image = UIImage(data:dataImagen!)
                    self.splashIma.image = image
                }})
        }
        
        view.addSubview(splashIma)
        
        let color = self.meetingInfo.palette as ColorPalette
        tabBar.translucent = false
        tabBar.barTintColor = UIColor (rgba: color.color1 as String)
        tabBar.tintColor = UIColor (rgba: color.color3 as String)
        
        // Vista Eventos
           }
    
    override func viewDidAppear(animated: Bool) {
        self.confingVista()

    }
    
    func confingVista(){
        let sorete = NSSortDescriptor(key: "self.sortingAux", ascending: true)
        
        for obje in self.meetingInfo.views.sortedArrayUsingDescriptors([sorete]){
            
            let vi = obje as! View
            vi.fetchFromLocalDatastoreInBackground()
            
            
            if (vi.nameView == "navEvents")
            {
                if(NSUserDefaults.standardUserDefaults().boolForKey("listo"))
                {
                    engineSincro.taskete(gestionLlamaos.llamadoModuloPrograma())
                    
                }
                
                let vistaEventos = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaEventos.meeting = self.meetingInfo
                vistaEventos.stb = self.stb
                vistaEventos.navigationItem.rightBarButtonItem = nil
                
                var textoTab = "" as String
                var textoTab2 =  "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    textoTab2 = vi.altTextTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    textoTab2 = vi.altTextTabLg2 as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    textoTab2 = vi.altTextTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    textoTab2 = vi.altTextTab as String
                    
                }
                
                vistaEventos.titleView = textoTab
                vistaEventos.titleView2 = textoTab2

                if !(vi.icon.getData() == nil) {
                    vistaEventos.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 1)
                } else {
                    vistaEventos.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "programa"), tag: 1)
                }
                
                self.mutuControllers.addObject(vistaEventos)
                
            }
                // Vista Expositores
                
            else if (vi.nameView == "navSpeakers"){
                
                if(NSUserDefaults.standardUserDefaults().boolForKey("listo"))
                {
                    engineSincro.taskete(gestionLlamaos.llamadoModuloExpositores())
                    
                }
                
                let vistaExpositores = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaExpositores.meeting = self.meetingInfo
                vistaExpositores.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    
                }
                
                vistaExpositores.titleView = textoTab as String

                if !(vi.icon.getData() == nil) {
                    vistaExpositores.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 2)
                } else {
                    vistaExpositores.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "speaker"), tag: 2)
                }
                self.mutuControllers.addObject(vistaExpositores)
                
            }
                //Vista Sponsors
                
        else if (vi.nameView == "navSponsors"){
                

                if(NSUserDefaults.standardUserDefaults().boolForKey("listo"))
                {
                    engineSincro.taskete(gestionLlamaos.llamadoModuloCompany())
                    
                    
                    
                    println("sincroCompany")
               
                }
                
                let vistaSponsors = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaSponsors.meeting = self.meetingInfo
                vistaSponsors.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    
                }
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    
                }
                
                vistaSponsors.titleView = textoTab as String
                
                if !(vi.icon.getData() == nil) {
                    vistaSponsors.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 3)
                } else {
                    vistaSponsors.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "ads"), tag: 3)
                }
                
                self.mutuControllers.addObject(vistaSponsors)
                
            }
                //Vista Favoritos
                
            else if (vi.nameView == "navFavorites"){
                
                let vistaFavoritos = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaFavoritos.meeting = self.meetingInfo
                vistaFavoritos.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    
                }
                
                vistaFavoritos.titleView = textoTab as String
                
                if !(vi.icon.getData() == nil) {
                    vistaFavoritos.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 4)
                } else {
                    vistaFavoritos.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "favorite"), tag: 4)
                }
                
                self.mutuControllers.addObject(vistaFavoritos)
            }
                
                //Vista Librery
                
            else if (vi.nameView == "navLibrary"){
                
                
                let vistaLibrary = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaLibrary.meeting = self.meetingInfo
                vistaLibrary.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    
                }
                
                vistaLibrary.titleView = textoTab as String
                
                if !(vi.icon.getData() == nil) {
                    vistaLibrary.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 5)
                }
                else {
                    vistaLibrary.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "biblioteca"), tag: 5)
                }
                self.mutuControllers.addObject(vistaLibrary)
            }
                
                //Vista Gallery
            
            else if (vi.nameView == "navGallery"){
                
                let vistaGallery = stb.instantiateViewControllerWithIdentifier(vi.nameView as String) as! navigationViewControllerMeeting
                vistaGallery.meeting = self.meetingInfo
                vistaGallery.stb = self.stb
                
                var textoTab = "" as String
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoTab = vi.textTab as String
                    
                }
                else if(idioma == "en"){
                    
                    textoTab = vi.textTabLg2 as String
                    
                }
                    
                else if(idioma == "pt"){
                    
                    textoTab = vi.textTabLg3 as String
                    
                }
                    
                else{
                    
                    textoTab = vi.textTab as String
                    
                }
                
                vistaGallery.titleView = textoTab as String
                
                if !(vi.icon.getData() == nil) {
                    vistaGallery.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 6)
                }
                else {
                    vistaGallery.tabBarItem = UITabBarItem(title:textoTab as String, image:UIImage(named: "biblioteca"), tag: 6)
                }
                self.mutuControllers.addObject(vistaGallery)
            }
            
                //Vista Hoteles
                
            else if (vi.nameView == "navHotels"){
                
                let vistaHotels = stb.instantiateViewControllerWithIdentifier("navTrip") as! navigationViewControllerMeeting
                vistaHotels.meeting = self.meetingInfo
                vistaHotels.stb = self.stb
                vistaHotels.urlTrip =  "http://api.tripadvisor.com/api/partner/2.0/map/\(meetingInfo.place.geoPoint.latitude),\(meetingInfo.place.geoPoint.longitude)/hotels?key=1132c8ce47f14a3ca7e9d8ca7ddb5b73&distance=10&subcategory=hotel&lang=es_MX"  as String
                if !(vi.icon.getData() == nil) {
                    vistaHotels.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 7)
                }
                else {
                    vistaHotels.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(named: "biblioteca"), tag: 7)
                }
                self.mutuControllers.addObject(vistaHotels)
            }
            
                //Vista Restaurant
                
            else if (vi.nameView == "navRestaurant"){
                
                let vistaRestaurant = stb.instantiateViewControllerWithIdentifier("navTrip") as! navigationViewControllerMeeting
                vistaRestaurant.meeting = self.meetingInfo
                vistaRestaurant.stb = self.stb
                vistaRestaurant.urlTrip =  "http://api.tripadvisor.com/api/partner/2.0/map/\(meetingInfo.place.geoPoint.latitude),\(meetingInfo.place.geoPoint.longitude)/restaurants?key=1132c8ce47f14a3ca7e9d8ca7ddb5b73&distance=10&lang=es_MX" as String
                if !(vi.icon.getData() == nil) {
                    vistaRestaurant.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 7)
                }
                else {
                    vistaRestaurant.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(named: "biblioteca"), tag: 7)
                }
                self.mutuControllers.addObject(vistaRestaurant)
            }
            
            else if (vi.nameView == "navAtracciones"){
                
                let vistaRestaurant = stb.instantiateViewControllerWithIdentifier("navTrip") as! navigationViewControllerMeeting
                vistaRestaurant.meeting = self.meetingInfo
                vistaRestaurant.stb = self.stb
                vistaRestaurant.urlTrip =  "http://api.tripadvisor.com/api/partner/2.0/map/\(meetingInfo.place.geoPoint.latitude),\(meetingInfo.place.geoPoint.longitude)/attractions?key=1132c8ce47f14a3ca7e9d8ca7ddb5b73&distance=10&lang=es_MX" as String
                if !(vi.icon.getData() == nil) {
                    vistaRestaurant.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(data: vi.icon.getData()!,scale:2.0), tag: 7)
                }
                else {
                    vistaRestaurant.tabBarItem = UITabBarItem(title:vi.textTab as String, image:UIImage(named: "biblioteca"), tag: 7)
                }
                self.mutuControllers.addObject(vistaRestaurant)
            }
            
        }
        self.viewControllers = self.mutuControllers as [AnyObject]

    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //arreglar esta huea
        if(NSUserDefaults.standardUserDefaults().boolForKey("listo"))
        {
            
            engineSincro.taskete(gestionLlamaos.llamaBaseMeeting())
            
        }
    }}
