//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Tool"}
    
    
    class Tool: PFObject, PFSubclassing{
        
        @NSManaged var altText: NSString
        @NSManaged var altTextLg2: NSString
        @NSManaged var altTextLg3: NSString
        @NSManaged var icon: PFFile
        @NSManaged var text: NSString
        @NSManaged var textLg2: NSString
        @NSManaged var textLg3: NSString
        @NSManaged var toolName: NSString
        @NSManaged var type: NSString






        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        
      }

