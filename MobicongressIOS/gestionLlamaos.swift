//
//  gestionLlamaos.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 25-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class gestionLlamaos: NSObject {

    class func llamaCompanyApp() ->PFQuery! {
        
    var q = PFQuery(className:"CompanyApp")
        q.limit = 1000
        q.includeKey("companies")
        q.includeKey("companySplash")
        q.includeKey("hostedCompany")
        q.includeKey("logo")
        q.includeKey("meetingApps")
        q.includeKey("palette")
        q.includeKey("views")
        //company
        
        q.includeKey("companies.actors")
        q.includeKey("companies.catalogs")
        q.includeKey("companies.gallery")
        q.includeKey("companies.headerImage")
        q.includeKey("companies.headerVideo")
        q.includeKey("companies.library")
        q.includeKey("companies.location")
        q.includeKey("companies.logo")

    //hostedCompany
        
        q.includeKey("hostedCompany.actors")
        q.includeKey("hostedCompany.actors.person")
        q.includeKey("hostedCompany.actors.person.profileImage")
        q.includeKey("hostedCompany.catalogs")
        q.includeKey("hostedCompany.gallery")
        q.includeKey("hostedCompany.headerImage")
        q.includeKey("hostedCompany.headerVideo")
        q.includeKey("hostedCompany.library")
        q.includeKey("hostedCompany.location")
        q.includeKey("hostedCompany.logo")
        
    //meetingApp
        
        q.includeKey("meetingApps.views")
        q.includeKey("meetingApps.companies")
        q.includeKey("meetingApps.companies.company")
        q.includeKey("meetingApps.companies.company.logo")
        q.includeKey("meetingApps.companies.company.gallery")
        q.includeKey("meetingApps.companies.company.gallery.logo")

        q.includeKey("meetingApps.place")
        q.includeKey("meetingApps.venues")
        q.includeKey("meetingApps.venues.maps")
        q.includeKey("meetingApps.palette")
        q.includeKey("meetingApps.events")
        q.includeKey("meetingApps.events.place")
        q.includeKey("meetingApps.events.library")
        q.includeKey("meetingApps.events.actors")
        q.includeKey("meetingApps.events.actors.person")
        q.includeKey("meetingApps.events.palette")
        q.includeKey("meetingApps.events.actors.person.profileImage")
        q.includeKey("meetingApps.events.view.toolBar")
        q.includeKey("meetingApps.events.actors.person")
        q.includeKey("meetingApps.persons")
        q.includeKey("meetingApps.persons.actors")
        q.includeKey("meetingApps.persons.profileImage")
        q.includeKey("meetingApps.icon")
        q.includeKey("meetingApps.library")
        q.includeKey("meetingApps.splashMeeting")
        q.includeKey("meetingApps.gallery")
        q.includeKey("meetingApps.walls")
        q.includeKey("meetingApps.walls.companyApp")
        q.includeKey("meetingApps.walls.meetingApp")
        q.includeKey("meetingApps.walls.news")
        q.includeKey("meetingApps.headerImage")
        q.includeKey("meetingApps.headerVideo")
        q.includeKey("meetingApps.hostingCompanyApp")

        
    //company.views
        
        q.includeKey("views.toolBar")
        q.includeKey("views.toolList")
        q.includeKey("views.sections")
        q.includeKey("views.sections.objects")
        q.includeKey("views.sections.objects.company")
        q.includeKey("views.sections.tableSections")
        q.includeKey("views.sections.tableSections.cell")
        q.includeKey("views.subViews")
        q.includeKey("views.subViews.sections")
        q.includeKey("views.subViews.sections.tableSections")
        q.includeKey("views.subViews.sections.tableSections.cell")
        
        return q
    }
    
    class func llamaBaseMeeting()-> PFQuery {
        
        var q = PFQuery(className:"CompanyApp")
        q.limit = 1000

        q.includeKey("meetingApps.companies.company")
        q.includeKey("meetingApps.companies.company.view")
        q.includeKey("meetingApps.companies.company.view.toolBar")
        q.includeKey("meetingApps.companies.company.actors")
        q.includeKey("meetingApps.companies.company.catalog")
        q.includeKey("meetingApps.companies.company.gallery")
        q.includeKey("meetingApps.companies.company.headerImage")
        q.includeKey("meetingApps.companies.company.headerVideo")
        q.includeKey("meetingApps.companies.company.library")
        q.includeKey("meetingApps.companies.company.location")
        q.includeKey("meetingApps.companies.company.logo")
        
        //meeting.events
        
        q.includeKey("meetingApps.events")
        q.includeKey("meetingApps.events.view")
        q.includeKey("meetingApps.events.gallery")
        q.includeKey("meetingApps.events.headerImage")
        q.includeKey("meetingApps.events.headerVideo")
        q.includeKey("meetingApps.events.hostingMeetingApps")
        q.includeKey("meetingApps.events.icon")
        q.includeKey("meetingApps.events.library")
        q.includeKey("meetingApps.events.palette")
        q.includeKey("meetingApps.events.place")
        q.includeKey("meetingApps.events.place.maps")
        q.includeKey("meetingApps.events.place.city")
        q.includeKey("meetingApps.events.place.country")
        q.includeKey("meetingApps.events.place.state")
        
        
    //meeting.events.actors
    
        q.includeKey("meetingApps.events.actors")
        q.includeKey("meetingApps.events.actors.person")
        q.includeKey("meetingApps.events.actors.person.actors")
        q.includeKey("meetingApps.events.actors.person.actors.events")
        q.includeKey("meetingApps.events.actors.person.company")
        q.includeKey("meetingApps.events.actors.person.headerImage")
        q.includeKey("meetingApps.events.actors.person.headerVideo")
        q.includeKey("meetingApps.events.actors.person.place")
        q.includeKey("meetingApps.events.actors.person.place.maps")
        q.includeKey("meetingApps.events.actors.person.place.city")
        q.includeKey("meetingApps.events.actors.person.place.country")
        q.includeKey("meetingApps.events.actors.person.place.state")
        q.includeKey("meetingApps.events.actors.person.profileImage")
        q.includeKey("meetingApps.events.actors.person.soul")
        
        
        q.includeKey("meetingApps.events.companies.company")
        q.includeKey("meetingApps.events.companies.company.actors")
        q.includeKey("meetingApps.events.companies.company.actors.person")
        q.includeKey("meetingApps.events.companies.company.catalogs")
        q.includeKey("meetingApps.events.companies.company.gallery")
        q.includeKey("meetingApps.events.companies.company.headerImage")
        q.includeKey("meetingApps.events.companies.company.headerVideo")
        q.includeKey("meetingApps.events.companies.company.library")
        q.includeKey("meetingApps.events.companies.company.location")
        q.includeKey("meetingApps.events.companies.company.logo")
        
        q.includeKey("meetingApps.events.view")
        q.includeKey("meetingApps.events.view.toolBar")
        q.includeKey("meetingApps.events.view.toolList")
        q.includeKey("meetingApps.events.view.sections")
        q.includeKey("meetingApps.events.view.sections.tableSections")
        q.includeKey("meetingApps.events.view.sections.tableSections.cell")
        q.includeKey("meetingApps.events.view.subViews")
        q.includeKey("meetingApps.events.view.subViews.sections")
        q.includeKey("meetingApps.events.view.subViews.sections.tableSections")
        q.includeKey("meetingApps.events.view.subViews.sections.tableSections.cell")
        
        //los anidaos
        q.includeKey("meetingApps.events.anidateEvents")
        q.includeKey("meetingApps.events.anidateEvents.view")
        q.includeKey("meetingApps.events.anidateEvents.gallery")
        q.includeKey("meetingApps.events.anidateEvents.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.hostingMeetingApps")
        q.includeKey("meetingApps.events.anidateEvents.icon")
        q.includeKey("meetingApps.events.anidateEvents.library")
        q.includeKey("meetingApps.events.anidateEvents.palette")
        q.includeKey("meetingApps.events.anidateEvents.place")
        q.includeKey("meetingApps.events.anidateEvents.place.maps")
        
        q.includeKey("meetingApps.events.anidateEvents.actors")
        q.includeKey("meetingApps.events.anidateEvents.actors.person")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.company")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.maps")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.city")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.country")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.state")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.profileImage")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.soul")
        
        q.includeKey("meetingApps.events.anidateEvents.companies.company")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors.person")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors.person.company")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.catalogs")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.gallery")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.library")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.location")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.logo")
        
        
        q.includeKey("meetingApps.events.anidateEvents.view")
        q.includeKey("meetingApps.events.anidateEvents.view.toolBar")
        q.includeKey("meetingApps.events.anidateEvents.view.toolList")
        q.includeKey("meetingApps.events.anidateEvents.view.sections")
        q.includeKey("meetingApps.events.anidateEvents.view.sections.tableSections")
        q.includeKey("meetingApps.events.anidateEvents.view.sections.tableSections.cell")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections.tableSections")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections.tableSections.cell")
        
        //meeting.persons
        q.includeKey("meetingApps.persons")
        q.includeKey("meetingApps.persons.view")
        q.includeKey("meetingApps.persons.place")
        q.includeKey("meetingApps.persons.place.maps")
        q.includeKey("meetingApps.persons.gallery")
        q.includeKey("meetingApps.persons.headerImage")
        q.includeKey("meetingApps.persons.headerVideo")
        q.includeKey("meetingApps.persons.actors")
        q.includeKey("meetingApps.persons.actors.events")
        q.includeKey("meetingApps.persons.actors.events.place")
        q.includeKey("meetingApps.persons.actors.events.place")
        q.includeKey("meetingApps.persons.actors.person")
        q.includeKey("meetingApps.persons.actors.person.company.headerImage")
        q.includeKey("meetingApps.persons.actors.person.company.headerVideo")
        q.includeKey("meetingApps.persons.actors.person.place")
        q.includeKey("meetingApps.persons.actors.person.place.maps")
        q.includeKey("meetingApps.persons.actors.person.place.country")
        q.includeKey("meetingApps.persons.actors.person.place.city")
        q.includeKey("meetingApps.persons.actors.person.place.state")
        q.includeKey("meetingApps.persons.view.toolBar")
        q.includeKey("meetingApps.persons.view.section")
        
        //meeting.view
        q.includeKey("meetingApps.views")
        q.includeKey("meetingApps.views.toolBar")
        q.includeKey("meetingApps.views.toolList")
        q.includeKey("meetingApps.views.sections")
        q.includeKey("meetingApps.views.sections.tableSections")
        q.includeKey("meetingApps.views.sections.tableSections.cell")
        q.includeKey("meetingApps.views.subViews")
        q.includeKey("meetingApps.views.subViews.sections")
        q.includeKey("meetingApps.views.subViews.sections.tableSections")
        q.includeKey("meetingApps.views.subViews.sections.tableSections.cell")
        
        //meeting.wall
        q.includeKey("meetingApps.walls")
        q.includeKey("meetingApps.walls.companyApp")
        q.includeKey("meetingApps.walls.meetingApp")
        

        return q
    }
    
    

class func llamadoModuloPrograma() ->PFQuery
    {
    var q = PFQuery(className: "CompanyApp")
    q.limit = 1000
      
        //meeting.events
        q.includeKey("meetingApps.events")
        q.includeKey("meetingApps.events.view")
        q.includeKey("meetingApps.events.gallery")
        q.includeKey("meetingApps.events.headerImage")
        q.includeKey("meetingApps.events.headerVideo")
        q.includeKey("meetingApps.events.hostingMeetingApps")
        q.includeKey("meetingApps.events.icon")
        q.includeKey("meetingApps.events.library")
        q.includeKey("meetingApps.events.palette")
        q.includeKey("meetingApps.events.place")
        q.includeKey("meetingApps.events.place.maps")
        q.includeKey("meetingApps.events.place.city")
        q.includeKey("meetingApps.events.place.country")
        q.includeKey("meetingApps.events.place.state")
        
        
        //meeting.events.actors
        q.includeKey("meetingApps.events.actors")
        q.includeKey("meetingApps.events.actors.person")
        q.includeKey("meetingApps.events.actors.person.actors")
        q.includeKey("meetingApps.events.actors.person.actors.events")
        q.includeKey("meetingApps.events.actors.person.company")
        q.includeKey("meetingApps.events.actors.person.headerImage")
        q.includeKey("meetingApps.events.actors.person.headerVideo")
        q.includeKey("meetingApps.events.actors.person.place")
        q.includeKey("meetingApps.events.actors.person.place.maps")
        q.includeKey("meetingApps.events.actors.person.place.city")
        q.includeKey("meetingApps.events.actors.person.place.country")
        q.includeKey("meetingApps.events.actors.person.place.state")
        q.includeKey("meetingApps.events.actors.person.profileImage")
        q.includeKey("meetingApps.events.actors.person.soul")
        
        
        q.includeKey("meetingApps.events.companies.company")
        q.includeKey("meetingApps.events.companies.company.actors")
        q.includeKey("meetingApps.events.companies.company.actors.person")
        q.includeKey("meetingApps.events.companies.company.catalogs")
        q.includeKey("meetingApps.events.companies.company.gallery")
        q.includeKey("meetingApps.events.companies.company.headerImage")
        q.includeKey("meetingApps.events.companies.company.headerVideo")
        q.includeKey("meetingApps.events.companies.company.library")
        q.includeKey("meetingApps.events.companies.company.location")
        q.includeKey("meetingApps.events.companies.company.logo")
        
        q.includeKey("meetingApps.events.view")
        q.includeKey("meetingApps.events.view.toolBar")
        q.includeKey("meetingApps.events.view.toolList")
        q.includeKey("meetingApps.events.view.sections")
        q.includeKey("meetingApps.events.view.sections.tableSections")
        q.includeKey("meetingApps.events.view.sections.tableSections.cell")
        q.includeKey("meetingApps.events.view.subViews")
        q.includeKey("meetingApps.events.view.subViews.sections")
        q.includeKey("meetingApps.events.view.subViews.sections.tableSections")
        q.includeKey("meetingApps.events.view.subViews.sections.tableSections.cell")
        
        //los anidaos
        q.includeKey("meetingApps.events.anidateEvents")
        q.includeKey("meetingApps.events.anidateEvents.view")
        q.includeKey("meetingApps.events.anidateEvents.gallery")
        q.includeKey("meetingApps.events.anidateEvents.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.hostingMeetingApps")
        q.includeKey("meetingApps.events.anidateEvents.icon")
        q.includeKey("meetingApps.events.anidateEvents.library")
        q.includeKey("meetingApps.events.anidateEvents.palette")
        q.includeKey("meetingApps.events.anidateEvents.place")
        q.includeKey("meetingApps.events.anidateEvents.place.maps")
        
        q.includeKey("meetingApps.events.anidateEvents.actors")
        q.includeKey("meetingApps.events.anidateEvents.actors.person")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.company")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.maps")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.city")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.country")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.place.state")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.profileImage")
        q.includeKey("meetingApps.events.anidateEvents.actors.person.soul")
        
        q.includeKey("meetingApps.events.anidateEvents.companies.company")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors.person")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.actors.person.company")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.catalogs")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.gallery")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.headerImage")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.headerVideo")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.library")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.location")
        q.includeKey("meetingApps.events.anidateEvents.companies.company.logo")
        
        
        q.includeKey("meetingApps.events.anidateEvents.view")
        q.includeKey("meetingApps.events.anidateEvents.view.toolBar")
        q.includeKey("meetingApps.events.anidateEvents.view.toolList")
        q.includeKey("meetingApps.events.anidateEvents.view.sections")
        q.includeKey("meetingApps.events.anidateEvents.view.sections.tableSections")
        q.includeKey("meetingApps.events.anidateEvents.view.sections.tableSections.cell")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections.tableSections")
        q.includeKey("meetingApps.events.anidateEvents.view.subViews.sections.tableSections.cell")

    
    return q
    }

    class func llamadoModuloExpositores() ->PFQuery
    {
        var q = PFQuery(className: "CompanyApp")
        q.limit = 1000
        
        q.includeKey("meetingApps.persons")
        q.includeKey("meetingApps.persons.pallette")
        q.includeKey("meetingApps.persons.view")
        q.includeKey("meetingApps.persons.place")
        q.includeKey("meetingApps.persons.place.maps")
        q.includeKey("meetingApps.persons.gallery")
        q.includeKey("meetingApps.persons.headerImage")
        q.includeKey("meetingApps.persons.headerVideo")
        q.includeKey("meetingApps.persons.actors")
        q.includeKey("meetingApps.persons.actors.events.place")
        q.includeKey("meetingApps.persons.actors.events.palette")
        q.includeKey("meetingApps.persons.actors.person")
        q.includeKey("meetingApps.persons.actors.person")
        q.includeKey("meetingApps.persons.actors.person.company.headerImage")
        q.includeKey("meetingApps.persons.actors.person.company.headerVideo")
        q.includeKey("meetingApps.persons.actors.person.place")
        q.includeKey("meetingApps.persons.actors.person.place.maps")
        q.includeKey("meetingApps.persons.actors.person.place.country")
        q.includeKey("meetingApps.persons.actors.person.place.city")
        q.includeKey("meetingApps.persons.actors.person.place.state")
        q.includeKey("meetingApps.persons.view.toolBar")
        q.includeKey("meetingApps.persons.view.section")

        
    return q
    }
    
    class func llamadoModuloCompany() ->PFQuery
    {
        var q = PFQuery(className: "CompanyApp")
        q.limit = 1000
        q.includeKey("meetingApps.companies.company")
        q.includeKey("meetingApps.companies.company.view")
        q.includeKey("meetingApps.companies.company.view.toolBar")
        q.includeKey("meetingApps.companies.company.actors")
        q.includeKey("meetingApps.companies.company.catalog")
        q.includeKey("meetingApps.companies.company.headerImage")
        q.includeKey("meetingApps.companies.company.headerVideo")
        q.includeKey("meetingApps.companies.company.library")
        q.includeKey("meetingApps.companies.company.location")
        q.includeKey("meetingApps.companies.company.logo")
        q.includeKey("meetingApps.companies.company.gallery")
        q.includeKey("meetingApps.companies.company.gallery.company")
        q.includeKey("meetingApps.companies.company.gallery.company.logo")
        q.includeKey("meetingApps.companies.company.gallery.company.logo.parseFileV1")


        
        
        return q
    }
    
   }