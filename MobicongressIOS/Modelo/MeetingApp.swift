//
//  AppJr.swift
//  mobiCongress
//
//  Created by Arturo Sanhueza on 31-12-14.
//  Copyright (c) 2014 mobiCongress. All rights reserved.
//

import UIKit
import Parse
private struct clase { static var nombre: String = "MeetingApp"}

class MeetingApp: PFObject,PFSubclassing {
    
    @NSManaged var active: Bool
    @NSManaged var actorChargesLoad: NSArray
    @NSManaged var actorChargesLoadLg2: NSArray
    @NSManaged var actorChargesLoadLg3: NSArray
    @NSManaged var channels: NSArray
    @NSManaged var companies: NSArray
    @NSManaged var endDate: NSDate
    @NSManaged var eventTags: NSArray
    @NSManaged var eventTagsLg2: NSArray
    @NSManaged var eventTagsLg3: NSArray
    @NSManaged var eventTypes: NSArray
    @NSManaged var events: NSArray
    @NSManaged var details: NSString
    @NSManaged var detailsLg2: NSString
    @NSManaged var detailsLg3: NSString
    @NSManaged var eventTagsLoad: NSString
    @NSManaged var eventTagsLoadLg2: NSString
    @NSManaged var eventTagsLoadLg3: NSString
    @NSManaged var eventTypeLoad: NSString
    @NSManaged var eventTypeLoadLg2: NSString
    @NSManaged var eventTypeLoadLg3: NSString
    @NSManaged var gallery: NSArray
    @NSManaged var headerImage:MobiFile
    @NSManaged var headerVideo:MobiFile
    @NSManaged var hostingCompanyApp:CompanyApp
    @NSManaged var icon:MobiFile
    @NSManaged var language: NSString
    @NSManaged var language2: NSString
    @NSManaged var language3: NSString
    @NSManaged var library: NSArray
    @NSManaged var name: NSString
    @NSManaged var nameLg2: NSString
    @NSManaged var nameLg3: NSString
    @NSManaged var palette: ColorPalette
    @NSManaged var personTagsLoad: NSArray
    @NSManaged var personTagsLoadLg2: NSArray
    @NSManaged var personTagsLoadLg3: NSArray
    @NSManaged var persons: NSArray
    @NSManaged var place:Place
    @NSManaged var polls: NSArray
    @NSManaged var size: NSNumber
    @NSManaged var splashMeeting: MobiFile
    @NSManaged var startDate: NSDate
    @NSManaged var status: NSString
    @NSManaged var subMeeting: Bool
    @NSManaged var subMeetings: NSArray
    @NSManaged var venues: NSArray
    @NSManaged var views: NSArray
    @NSManaged var walls: NSArray

    override class func initialize() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String {
        
        return clase.nombre
    }
    
}