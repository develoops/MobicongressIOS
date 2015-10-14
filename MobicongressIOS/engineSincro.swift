//
//  engineSincro.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 08-04-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class engineSincro: NSObject {
   
    
    class func taskete(q:PFQuery){
        
        q.findObjectsInBackground().continueWithSuccessBlock {(task: BFTask!) -> AnyObject in
            
            return PFObject.unpinAllObjectsInBackgroundWithName("CompanyApp").continueWithSuccessBlock({ (ignorante:BFTask!) -> AnyObject! in
                
                if(task.completed){
                    NSNotificationCenter.defaultCenter().postNotificationName("listo", object: nil)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "listo")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                return PFObject.pinAllInBackground(task.result as! NSArray as [AnyObject], withName:"CompanyApp")
            })
        }
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "listo")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
    
}
