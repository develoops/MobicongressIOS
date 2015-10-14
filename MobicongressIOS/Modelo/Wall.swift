//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Wall"}
    
    
    class Wall: PFObject, PFSubclassing{
        
        @NSManaged var comanyApp: Company
        @NSManaged var facebook: NSString
        @NSManaged var meetingApp: MeetingApp
        @NSManaged var news: NSArray
        @NSManaged var twitter: NSString
        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
    }

