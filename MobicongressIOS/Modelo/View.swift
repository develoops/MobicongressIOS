//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "View"}
    
    
    class View: PFObject, PFSubclassing{
        
        @NSManaged var active: NSString
        @NSManaged var altTextTab: NSString
        @NSManaged var altTextTabLg2: NSString
        @NSManaged var altTextTabLg3: NSString
        @NSManaged var icon: PFFile
        @NSManaged var nameView: NSString
        @NSManaged var sections: NSArray
        @NSManaged var subViews: NSArray
        @NSManaged var textTab: NSString
        @NSManaged var textTabLg2: NSString
        @NSManaged var textTabLg3: NSString
        @NSManaged var title: NSString
        @NSManaged var titleLg2: NSString
        @NSManaged var titleLg3: NSString
        @NSManaged var toolBar: NSArray
        @NSManaged var toolList: NSArray
        @NSManaged var type: NSString






        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
    }

