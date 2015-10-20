//
//  sponsorDetailViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 3/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MessageUI


class sponsorDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate  {

    var companyAboutInfo: Facade!
    var meetingApp: MeetingApp!
    var confVista: View!
    var gallery = [UIImage]()
    var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailEventView.tabla1.delegate = self
        detailEventView.tabla1.dataSource = self
        detailEventView.tablaHeader.delegate = self
        detailEventView.tablaHeader.dataSource = self
        detailEventView.tablaSpeaker.delegate = self
        detailEventView.tablaSpeaker.dataSource = self
        detailEventView.tablaEvento.delegate = self
        detailEventView.tablaEvento.dataSource = self
        detailEventView.tablaDescripcion.delegate = self
        detailEventView.tablaDescripcion.dataSource = self
    
        companyAboutInfo.fetchFromLocalDatastoreInBackground()
        
       
        for object in companyAboutInfo.company.gallery{
            
            let a = object as! Company

            a.fetchFromLocalDatastoreInBackground().continueWithBlock({ (task:BFTask!) -> AnyObject! in
                
                let logo = task.result.valueForKey("logo") as! MobiFile
                
                return  logo.parseFileV1.getDataInBackground().continueWithBlock({ (taskLogo:BFTask!) -> AnyObject! in
                    
                    let image = UIImage(data: taskLogo.result as! NSData)
                    self.gallery.append(image!)
                    
                    return task
                })
            })
        }
        
        detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 110)
        detailEventView.backgroundColor = UIColor (rgba: meetingApp.palette.color2 as String)
        
        view.addSubview(detailEventView)
        
        detailEventView.toolBar.barTintColor = UIColor (rgba: meetingApp.palette.color4 as String)
        detailEventView.toolBar.tintColor = UIColor .whiteColor()
        
        var mutu = NSMutableArray()
        if(companyAboutInfo.company.view.isDataAvailable()){
            let visti = companyAboutInfo.company.view as View
            visti.fetchFromLocalDatastoreInBackground()
            
            for t in visti.toolBar as NSArray{
                
                if let tab = t as? Tool{
                    tab.fetchFromLocalDatastoreInBackground()
                    
                    let fun = (tab.toolName as String) + ":"
                    
                    var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
                    mutu.addObject(flexibleSpace)
                    
                    var item = UIBarButtonItem(title: tab.text as String, style: UIBarButtonItemStyle.Plain, target: self, action:NSSelectorFromString(fun))
                    item.width = (view.frame.width / 3)
                    mutu.addObject(item)
                }
            }
            detailEventView.toolBar.items = mutu as [AnyObject]
        } else {
            detailEventView.toolBar.hidden = true
        }
        
    }
    
    
    func funTwitter(sender: UIBarButtonItem) {
        println("twitiiir")
    }
    
    func funFacebook(sender: UIBarButtonItem) {
        println("feibu")
        
    }
    func funLinkedin(sender: UIBarButtonItem) {
        println("linkedine")
        
    }
    
    func funPhone(sender: UIBarButtonItem) {
        if let url = NSURL(string: "tel://\(companyAboutInfo.company.phone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func funMail(sender: UIBarButtonItem) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func funWeb(sender: UIBarButtonItem) {
        println("weba")
        let storyboard = UIStoryboard(name: "Meeting", bundle: nil)
        let filesVC = storyboard.instantiateViewControllerWithIdentifier("filesViewController") as! filesViewController
        filesVC.urling = companyAboutInfo.company.website
        self.navigationController?.pushViewController(filesVC, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        detailEventView.tabla1Height.constant = detailEventView.tabla1.contentSize.height
        
        detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
        detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
        detailEventView.tablaSpeakerHeight.constant = detailEventView.tablaSpeaker.contentSize.height
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if (tableView == detailEventView.tabla1) {
            
            return 1
        }
        
        if (tableView == detailEventView.tablaHeader) {
            
            return 1
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
            return 1
        }
        
        if (tableView == detailEventView.tablaSpeaker) {
            
            return self.gallery.count
        }
        if (tableView == detailEventView.tablaEvento) {
            
            return 0
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var textoLabel1 = "" as NSString
        var textoLabel2 = "" as NSString
        var textoLabel3 = "" as NSString
        var textoLabel4 = "" as NSString
        var textoLabel5 = "" as NSString
    
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 0
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.companyAboutInfo.company.headerImage
            mobiFi.fetchFromLocalDatastoreInBackground()
            if (mobiFi.isDataAvailable()) {
                
                heightImagen = self.view.frame.height * 0.25
                
            } else {
                
                cell.imageFull.hidden = true
                heightImagen = 0
            }
        }
        
        if (tableView == detailEventView.tablaHeader) {
            
            textoLabel1 = self.companyAboutInfo.company.name
            heightImagen = 70
            
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
            if(self.companyAboutInfo.company.details.length != 0){
                textoLabel1 = self.companyAboutInfo.company.details
            
            }
        
       }
        
        if (tableView == detailEventView.tablaSpeaker) {
            
            if(self.gallery.count != 0){
                heightImagen = 70
                
            }
        }

        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = textoLabel1 as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0,cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoMediano
        label3.text = textoLabel3 as String
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = cell.fontTextoMediano
        label4.text = textoLabel4 as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = cell.fontTextoMediano
        label5.text = textoLabel5 as String
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        label4.sizeToFit()
        label5.sizeToFit()
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 20
        
        if (heightTexto > heightImagen) {
            height = heightTexto
        } else {
            height = heightImagen + 10
        }
        
        return height
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.companyAboutInfo.company.headerImage
            mobiFi.fetchFromLocalDatastoreInBackground()
            if (mobiFi.isDataAvailable()) {
                
                let ima = mobiFi.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)
                        
                    }
                    else{
                        
                        let image = UIImage(data:dataImagen!)
                        cell.imageFull.image = image
                        cell.imageFull.hidden = false
                        
                        println(mobiFi.parseFileV1.name)
                        
                    }
                })
                
            } else {
                cell.imageFull.hidden = true
            }
            
        }
        
        if (tableView == detailEventView.tablaHeader) {
            
            cell.backgroundColor = UIColor (rgba: meetingApp.palette.color4 as String)
            
            cell.label1Top.constant = 35
            cell.label1.text = companyAboutInfo.company.name as String
            cell.label1Right.constant = 15
            cell.label1.textColor = UIColor .whiteColor()
            
            if (self.companyAboutInfo.company.logo.isDataAvailable()) {
                
                
                let ima = companyAboutInfo.company.logo.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)}
                        
                    else{
                        
                        let image = UIImage(data:dataImagen!)
                        cell.imagen.backgroundColor = UIColor .whiteColor()
                        cell.imagen.image = image
                        cell.imagenTop.constant = 0
                        cell.imagenBot.constant = 0
                        cell.imagenHeight.constant = 90
                        cell.imagenWidth.constant = 90
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                        
                    }})

            } else {
                
                cell.imagenWidth.constant = 0
                
            }
        }
        
        if (tableView == detailEventView.tablaDescripcion) {

            if(companyAboutInfo.company.details.length != 0){
            cell.label1.text = companyAboutInfo.company.details as String
            cell.label1.font = UIFont(name: "ArialMT", size: 13)
            
            cell.imagenWidth.constant = 0
            cell.viewContentLeft.constant = 10
            cell.viewContentTop.constant = 5
            cell.viewContentRight.constant = 10
            cell.viewContentBot.constant = 5
            }
            return cell
            
        }
            
        else if (tableView == detailEventView.tablaSpeaker){
            
            
            let image = self.gallery[indexPath.row]
            cell.imagen.backgroundColor = UIColor .whiteColor()
            cell.imagen.image = image
            cell.imagenTop.constant = 0
            cell.imagenBot.constant = 0
            cell.imagenHeight.constant = 90
            cell.imagenWidth.constant = 90
            cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit

            return cell
        }
            
        else if (tableView == detailEventView.tablaEvento) {
            
            
            return cell
            
        }
        
        return cell
    }
    //Fuciones mail
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([companyAboutInfo.company.mail])
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "No se pudo enviar el correo", message: "Su dispositivo no esta habilitado para enviar correos.  Por favor revise su configuración de correos y vuelva a intentarlo.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}