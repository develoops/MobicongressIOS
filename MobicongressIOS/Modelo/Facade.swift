//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Facade"}
    
    
    class Facade: PFObject, PFSubclassing{
        
        @NSManaged var active: Bool
        @NSManaged var company: Company
        @NSManaged var companyApps: NSArray
        @NSManaged var events: NSArray
        @NSManaged var meetingApps: NSArray
        @NSManaged var role: NSString
        @NSManaged var roleLg2: NSString
        @NSManaged var roleLg3: NSString



        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
}

