//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Company"}
    
    
    class Company: PFObject, PFSubclassing{

        @NSManaged var active: Bool
        @NSManaged var actors: NSArray
        @NSManaged var catalog: NSArray
        @NSManaged var details: NSString
        @NSManaged var detailsLg2: NSString
        @NSManaged var detailsLg3: NSString
        @NSManaged var facebook: NSString
        @NSManaged var gallery: NSArray
        @NSManaged var headerImage: MobiFile
        @NSManaged var headerVideo: MobiFile
        @NSManaged var library: NSArray
        @NSManaged var linkedin: NSString
        @NSManaged var location: Place
        @NSManaged var logo: MobiFile
        @NSManaged var name: NSString
        @NSManaged var nameLg2: NSString
        @NSManaged var nameLg3: NSString
        @NSManaged var mail: NSString
        @NSManaged var phone: NSString
        @NSManaged var place: Place
        @NSManaged var soul: PFRelation
        @NSManaged var subtitle: NSString
        @NSManaged var subtitleLg2: NSString
        @NSManaged var subtitleLg3: NSString
        @NSManaged var title: NSString
        @NSManaged var titleLg2: NSString
        @NSManaged var titleLg3: NSString
        @NSManaged var twitter: NSString
        @NSManaged var type: NSString
        @NSManaged var view: View
        @NSManaged var website: NSString
        


    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        
           }

