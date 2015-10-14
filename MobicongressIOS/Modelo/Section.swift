//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Section"}
    
    
    class Section: PFObject, PFSubclassing{
        
        
        @NSManaged var nameSection: NSString
        @NSManaged var isCustomized: Bool
        @NSManaged var objects: NSArray
        @NSManaged var tableSections: NSArray
        @NSManaged var titleLg: NSString
        @NSManaged var titleLg2: NSString
        @NSManaged var titleLg3: NSString
        @NSManaged var type: NSString
        
    override class func initialize  () {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
}

