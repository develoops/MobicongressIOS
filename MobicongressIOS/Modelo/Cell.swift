//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Cell"}
    
    
    class Cell: PFObject, PFSubclassing{
        
    @NSManaged var active: Bool
    @NSManaged var cellName: NSString
    @NSManaged var image: PFFile
    @NSManaged var imageAtributte: NSString
    @NSManaged var isTouch: Bool
    @NSManaged var label1: NSString
    @NSManaged var label2: NSString
    @NSManaged var label3: NSString
    @NSManaged var label4: NSString
    @NSManaged var label5: NSString
    @NSManaged var showImage: Bool





        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
    }

