//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "CompanyApp"}
    
    class CompanyApp: PFObject, PFSubclassing{
        
        @NSManaged var active: Bool
        @NSManaged var channels: NSArray
        @NSManaged var companies: NSArray
        @NSManaged var companySplash: MobiFile
        @NSManaged var hostedCompany: Company
        @NSManaged var installation: NSArray
        @NSManaged var language1: NSString
        @NSManaged var language2: NSString
        @NSManaged var language3: NSString
        @NSManaged var logo: MobiFile
        @NSManaged var meetingApps: NSArray
        @NSManaged var palette: ColorPalette
        @NSManaged var title: NSString
        @NSManaged var titleLg2: NSString
        @NSManaged var titleLg3: NSString
        @NSManaged var views: NSArray


        override class func initialize() {
            var onceToken : dispatch_once_t = 0;
            dispatch_once(&onceToken) {
                self.registerSubclass()
            }
        }
        
        
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
        
}


