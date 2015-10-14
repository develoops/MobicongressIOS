//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "MobiFile"}
    
    
    class MobiFile: PFObject, PFSubclassing{

    @NSManaged var active: Bool
    @NSManaged var parseFileV1: PFFile
    @NSManaged var parseFileV2: PFFile
    @NSManaged var parseFileV3: PFFile
    @NSManaged var size: NSNumber
    @NSManaged var subtype: NSString
    @NSManaged var thumbnail: PFFile
    @NSManaged var title: NSString
    @NSManaged var titleLg2: NSString
    @NSManaged var titleLg3: NSString
    @NSManaged var type: NSString
    @NSManaged var urlSource: NSString
        
    override class func initialize() {
            self.registerSubclass()
    }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
}

