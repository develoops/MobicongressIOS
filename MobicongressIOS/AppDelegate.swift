
//
//  AppDelegate.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //--------------------------------------
    //  MARK: - UIApplicationDelegate
    //--------------------------------------
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let defol = NSUserDefaults.standardUserDefaults()
        let i = defol.integerForKey("lanza") as Int
        println(i)
        var pre = NSLocale.preferredLanguages()[0] as! NSString
        //var pre = "es" as! NSString

        defol.setInteger(i+1, forKey: "lanza")
        println(pre.substringToIndex(2))
        defol.setValue(pre.substringToIndex(2), forKey: "idioma")
        defol.synchronize()
        
        
        CompanyApp.registerSubclass()
        Actor.registerSubclass()
        Cell.registerSubclass()
        ColorPalette.registerSubclass()
        Company.registerSubclass()
        MobiFile.registerSubclass()
        Event.registerSubclass()
        Facade.registerSubclass()
        MeetingApp.registerSubclass()
        New.registerSubclass()
        Person.registerSubclass()
        Place.registerSubclass()
        Rating.registerSubclass()
        Section.registerSubclass()
        TableSection.registerSubclass()
        Tool.registerSubclass()
        View.registerSubclass()
        Wall.registerSubclass()
         
        Parse.enableLocalDatastore()
    
        //
        
        Parse.setApplicationId("E9xPHRRWXnCHUzkoLnVRwglar83y7p2GIc6bU1XY", clientKey: "d9Xs8TV5RA7YcxvXVqPCRVe1pLCc3vgPhpxPR4tG")
        
        //
        
        PFUser.enableAutomaticUser()
        PFUser.currentUser()?.saveInBackground()
        engineSincro.taskete(gestionLlamaos.llamaCompanyApp())
        let defaultACL = PFACL();
        
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
        if application.applicationState != UIApplicationState.Background {
            
        let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
        let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var noPushPayload = false;
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            application.registerForRemoteNotificationTypes(types)
        }

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        var initialViewController = storyboard.instantiateViewControllerWithIdentifier("launch") as! MCLaunchViewController
                
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        self .configurarNavBar()
        
        return true
        
    }
    
    func configurarNavBar() {
        
        var navigationBarAppearace = UINavigationBar.appearance()
        //navigationBarAppearace.translucent = false
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
        let defol = NSUserDefaults.standardUserDefaults()
        defol.setInteger(0, forKey: "splash")
        defol.synchronize()
        
        
    }
    

    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
        
        PFPush.subscribeToChannelInBackground("", block: { (succeeded, error) -> Void in
            if succeeded {
                println("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
            } else {
                println("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.", error)
            }
        })
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            println("Push notifications are not supported in the iOS Simulator.")
        } else {
            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }

    /////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    /////////////////////////////////////////////////////////
//     func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//         if application.applicationState == UIApplicationState.Inactive {
//             PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
//         }
//     }

    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    //     return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
    // }
}
