//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Actor"}
    
    
    class Actor: PFObject, PFSubclassing{
        
        @NSManaged var active: Bool
        @NSManaged var charge: NSString
        @NSManaged var chargeLg2: NSString
        @NSManaged var chargeLg3: NSString
        @NSManaged var companies: NSArray
        @NSManaged var events: NSArray
        @NSManaged var person: Person
        @NSManaged var type: NSString

        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        }

