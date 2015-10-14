//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "TableSection"}
    
    
    class TableSection: PFObject, PFSubclassing{
        
        @NSManaged var cell: Cell
        @NSManaged var headerText: NSString
        @NSManaged var headerTextLg2: NSString
        @NSManaged var headerTextLg3: NSString
        @NSManaged var showHeader: Bool
        @NSManaged var sortingCriteria: NSString
        @NSManaged var tag: NSString





        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        
      }

