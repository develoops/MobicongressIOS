//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "ColorPalette"}
    
    
    class ColorPalette: PFObject, PFSubclassing{
        
        @NSManaged var color1: NSString
        @NSManaged var color2: NSString
        @NSManaged var color3: NSString
        @NSManaged var color4: NSString
        @NSManaged var color5: NSString
        @NSManaged var paletteName: NSString
        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        }

