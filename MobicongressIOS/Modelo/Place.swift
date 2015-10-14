//
//  Place.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 01-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

import UIKit
import Parse

private struct clase { static var nombre: String = "Place"}


class Place: PFObject, PFSubclassing{
    
    @NSManaged var active: Bool
    @NSManaged var adress: NSString
    @NSManaged var city: Place
    @NSManaged var country: Place
    @NSManaged var geoPoint: PFGeoPoint
    @NSManaged var googleMaps: NSString
    @NSManaged var maps: NSArray
    @NSManaged var name: NSString
    @NSManaged var nameLg2: NSString
    @NSManaged var nameLg3: NSString
    @NSManaged var state: Place
    @NSManaged var tripAdvisor: NSString
    @NSManaged var type: NSString
    @NSManaged var x: NSNumber
    @NSManaged var y: NSNumber
    
    
    
    override class func initialize() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String {
        
        return clase.nombre
    }
}

