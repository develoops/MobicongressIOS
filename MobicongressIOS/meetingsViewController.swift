//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class meetingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var ind = NSIndexPath()
    var defolto = NSUserDefaults()
    var tabla = UITableView()
    var meetingApps:CompanyApp!
    var arrayMeetings = NSArray()
    var window: UIWindow?
    var acOffline:UILabel!
    let device = Device()
    var titleView : String!
    
    func aparecerAvisoOffline() {
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("removerAvisoOffline"), userInfo: nil, repeats: false)
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 25))
        label1.textAlignment = NSTextAlignment.Center
        label1.font = UIFont(name: "ArialMT", size: 15)
        label1.text = "Se encuentra en modo sin conexión"
        label1.sizeToFit()
        
        acOffline = UILabel (frame: CGRectMake(((view.frame.width * 0.5) - (label1.frame.width + 20) / 2), tabla.frame.height - 40 , label1.frame.width + 20, 25))
        acOffline.text = "Se encuentra en modo sin conexión"
        acOffline.textColor = UIColor .whiteColor()
        acOffline.textAlignment = NSTextAlignment.Center
        acOffline.font = UIFont(name: "ArialMT", size: 15)
        acOffline.backgroundColor = UIColor .darkGrayColor().colorWithAlphaComponent(0.8)
        acOffline.layer.cornerRadius = 9
        acOffline.layer.masksToBounds = true
        acOffline.alpha = 0
        
        view.addSubview(acOffline)
        acOffline.fadeIn()
        
    }
    
    func removerAvisoOffline() {
        
        acOffline.fadeOut()
        
    }

    override func viewDidLoad() {
        
        // AvisoContextual de Modo Offline

        if (Reachability.reachabilityForInternetConnection().currentReachabilityString == "No Connection") {
            var timer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("aparecerAvisoOffline"), userInfo: nil, repeats: false)
        }

        let color = self.meetingApps.palette as ColorPalette
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        let sorete = NSSortDescriptor(key: "self.position", ascending: true)
        self.arrayMeetings = self.meetingApps.meetingApps.sortedArrayUsingDescriptors([sorete]) as NSArray
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 113)
        
        self.view.addSubview(self.tabla)
       
        self.title = titleView
        
        view.backgroundColor = UIColor(rgba: color.color2 as String)
        tabla.separatorColor = UIColor .clearColor()
        tabla.backgroundColor = UIColor .clearColor()
        tabla.rowHeight = UITableViewAutomaticDimension
        tabla.estimatedRowHeight = 100
        tabla.contentInset.bottom = 10
}
    override func viewDidAppear(animated: Bool) {
        self.tabla.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayMeetings.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 80
        var widthCell:CGFloat!
        
        var cell: meetingCell = tabla.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if device == .iPhone6Plus {
            
            widthCell = cell.frame.width
            
        }
        
        if device == .iPhone6 {
            
            widthCell = cell.frame.width - 80
 
        }
        
        if device == .iPhone5s || device == .iPhone5c || device == .iPhone5 || device == .iPhone4s {
            
            widthCell = cell.viewInfo.frame.width - 30
            
        } else {
            
            widthCell = cell.frame.width - 40
        
        }
    
        if device == .Simulator {
            
            if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue <= 8) {
    
                    widthCell = cell.viewInfo.frame.width - 30
    
            } else {
    
                    widthCell = cell.frame.width
            }

    
        }

    
        let meet = self.arrayMeetings.objectAtIndex(indexPath.row) as! MeetingApp
        let lugare = meet.place as Place
        lugare.fetchFromLocalDatastoreInBackground()
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = meet.name as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell - 50, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode =  cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = "Sheraton Miramar Hotel & Convention Center"
        //se cae en offline
        //label2.text = meet.place.name as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoMediano
        var fechaInicio = MCDateFormatter().NumeroDelDia().stringFromDate(meet.startDate)
        var fechaFin = MCDateFormatter().DiaMesAno().stringFromDate(meet.endDate)
        label3.text = "\(fechaInicio) - \(fechaFin)"
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = cell.fontTextoMediano
        label4.text = cell.textoLabel4 as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = cell.fontTextoMediano
        label5.text = cell.textoLabel5 as String
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        label4.sizeToFit()
        label5.sizeToFit()
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 35

        
        if (heightTexto > heightImagen) {
            height = heightTexto
        } else {
            height = heightImagen + 10
        }
        
        if (meet.status == "subMeeting") {
            height = heightTexto
        }
        
        return height
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let meet = self.arrayMeetings.objectAtIndex(indexPath.row) as! MeetingApp
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        
        cell.viewContent.backgroundColor = UIColor .whiteColor()
        
        //arreglar
        
        cell.viewContentTop.constant = 5
        cell.viewContentRight.constant = 5
        cell.viewContentLeft.constant = 5
        cell.viewContentBot.constant = 0
        cell.imagenLeft.constant = 5

        cell.label1.text = meet.name as String
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            cell.label1.text = meet.name as String
            
        }
        else if(idioma == "en"){
            
            cell.label1.text = meet.nameLg2 as String
        }
            
        else if(idioma == "pt"){
            
            cell.label1.text = meet.nameLg3 as String
        }
            
        else{
            cell.label1.text = meet.name as String
            
        }
        
        cell.label2.text = meet.place.name as String
    
        var fechaInicio = MCDateFormatter().NumeroDelDia().stringFromDate(meet.startDate)
        var fechaFin = MCDateFormatter().DiaMesAno().stringFromDate(meet.endDate)
        cell.label3.text = "\(fechaInicio) - \(fechaFin)"
        
        cell.label1.font = cell.fontTextoGrande
        cell.label2.font = cell.fontTextoMediano
        cell.label3.font = cell.fontTextoMediano
        
        let iconoMeet = meet.icon as MobiFile
        iconoMeet.fetchFromLocalDatastoreInBackground()
        if (meet.icon.isDataAvailable()) {
            
            let ima = meet.icon.parseFileV1 as PFFile
            
            ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                
                if(error != nil){
                    
                    println(error)
                }
                    
                else{
                    let image = UIImage(data:dataImagen!)
                    cell.imagen.image = image
                    cell.imagenWidth.constant = 70
                    cell.imagenHeight.constant = 70
                    
                }
            })
        }

        if (meet.status == "subMeeting") {
            
            cell.viewContent.backgroundColor = UIColor (rgba: meet.palette.color5 as String)
            cell.viewInfo.backgroundColor = UIColor .whiteColor()
            
            cell.separator.backgroundColor = UIColor .clearColor()
            cell.imagenWidth.constant = 0
            cell.viewInfoLeft.constant = 20
            cell.viewContentTop.constant = 0
        
        }
        
        cell.needsUpdateConstraints()
        cell.layoutIfNeeded()//
        return cell
  
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tabla.deselectRowAtIndexPath(indexPath, animated: true)
        let meet = self.arrayMeetings.objectAtIndex(indexPath.row) as! MeetingApp

        let stb = UIStoryboard(name: "Meeting", bundle: nil)
        if(NSUserDefaults.standardUserDefaults().boolForKey("listo"))
        {
//            if(NSUserDefaults.standardUserDefaults().boolForKey(meet.objectId!) != true){
                engineSincro.taskete(gestionLlamaos.llamaBaseMeeting())
            
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: meet.objectId!)
//                NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
        
        let vistaEventos = stb.instantiateViewControllerWithIdentifier("tabEventos") as! MCTabBarViewControllerEventos

               for eventif in meet.events{
        eventif.fetchFromLocalDatastoreInBackground()
        
    }
        
        vistaEventos.meetingInfo = meet
        vistaEventos.stb = stb
        
        let meetSplash = meet.splashMeeting as MobiFile
        meetSplash.fetchFromLocalDatastoreInBackground()
        
        self.navigationController?.presentViewController(vistaEventos, animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

import Foundation
import UIKit

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
            }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            self.removeFromSuperview()
            }, completion: nil)
    }
}
