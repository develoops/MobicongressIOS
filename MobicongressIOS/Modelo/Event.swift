//
//  AppJr.swift
//  mobiCongress
//
//  Created by Arturo Sanhueza on 31-12-14.
//  Copyright (c) 2014 mobiCongress. All rights reserved.
//

import UIKit
import Parse
private struct clase { static var nombre: String = "Event"}


class Event: PFObject,PFSubclassing {
    
    @NSManaged var active: Bool
    @NSManaged var actors: NSArray
    @NSManaged var anidateEvents: NSArray
    @NSManaged var catalog: NSArray
    @NSManaged var companies: NSArray
    @NSManaged var details: NSString
    @NSManaged var detailsLg2: NSString
    @NSManaged var detailsLg3: NSString
    @NSManaged var endDate: NSDate
    @NSManaged var gallery: NSArray
    @NSManaged var headerImage: MobiFile
    @NSManaged var headerVideo: MobiFile
    @NSManaged var hostingMeetingApps: NSArray
    @NSManaged var icon: MobiFile
    @NSManaged var library: NSArray
    @NSManaged var palette: ColorPalette
    @NSManaged var place: Place
    @NSManaged var sortingAux: NSNumber
    @NSManaged var sponsored: Bool
    @NSManaged var startDate: NSDate
    @NSManaged var tags: NSArray
    @NSManaged var tagsLg2: NSArray
    @NSManaged var tagsLg3: NSArray
    @NSManaged var title: NSString
    @NSManaged var titleLg2: NSString
    @NSManaged var titleLg3: NSString
    @NSManaged var type: NSString
    @NSManaged var view: View

    override class func initialize() {
        self.registerSubclass()
    }
    
     func realTitulo() -> NSString{
     var titulo = NSString()
     let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            titulo = self.title
            
        }
        else if(idioma == "en"){
        
            titulo = self.titleLg2
        }
            
        else if(idioma == "pt"){
            
            titulo = self.titleLg3
        }
            
        else{
            titulo = self.title

        }
        
        return titulo
    }
    
    class func parseClassName() -> String {
        
        return clase.nombre
    }
}