//
//  CompanyApp.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 21-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

private struct clase { static var nombre: String = "Person"}
    
    
    class Person: PFObject, PFSubclassing{
        
        @NSManaged var activate: Bool
        @NSManaged var actors: NSArray
        @NSManaged var bio: NSString
        @NSManaged var bioLg2: NSString
        @NSManaged var bioLg3: NSString
        @NSManaged var catalog: NSArray
        @NSManaged var company: Company
        @NSManaged var facebook: NSString
        @NSManaged var firstName: NSString
        @NSManaged var gallery: NSArray
        @NSManaged var headerImage: MobiFile
        @NSManaged var headerVideo: MobiFile
        @NSManaged var library: NSArray
        @NSManaged var lastName: NSString
        @NSManaged var mail: NSString
        @NSManaged var phone: NSString
        @NSManaged var place: Place
        @NSManaged var profileImage:MobiFile
        @NSManaged var salutation: NSString
        @NSManaged var salutationLg2: NSString
        @NSManaged var salutationLg3: NSString
        @NSManaged var sortingAux: NSNumber
        @NSManaged var soul: PFRelation
        @NSManaged var twitter: NSString
        @NSManaged var view: View



        
    override class func initialize() {
            self.registerSubclass()
        }
        
        class func parseClassName() -> String {
            
            return clase.nombre
        }
    }

