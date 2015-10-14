//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Rating"}
    
    
    class Rating: PFObject, PFSubclassing{
        
        @NSManaged var active: NSString
        @NSManaged var comment: NSString
        @NSManaged var event: Event
        @NSManaged var type: NSString
        @NSManaged var value: NSNumber
        @NSManaged var user: PFUser



        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        
    }

