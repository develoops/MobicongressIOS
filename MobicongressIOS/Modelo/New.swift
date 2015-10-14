//
//  AppJr.swift
//  mobiCongress
//
//  Created by Arturo Sanhueza on 31-12-14.
//  Copyright (c) 2014 mobiCongress. All rights reserved.
//

import UIKit
import Parse
private struct clase { static var nombre: String = "New"}

class New: PFObject,PFSubclassing {
    
    @NSManaged var active: Bool
    @NSManaged var channels: NSArray
    @NSManaged var content: NSString
    @NSManaged var contentLg2: NSString
    @NSManaged var contentLg3: NSString
    @NSManaged var date: NSDate
    @NSManaged var image: MobiFile
    @NSManaged var isPush: Bool
    @NSManaged var isTouch: Bool
    @NSManaged var sender: NSString
    @NSManaged var sortingAux: NSNumber
    @NSManaged var title: NSString
    @NSManaged var titleLg2: NSString
    @NSManaged var titleLg3: NSString
    @NSManaged var walls: NSArray

    override class func initialize() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String {
        
        return clase.nombre
    }
    
}