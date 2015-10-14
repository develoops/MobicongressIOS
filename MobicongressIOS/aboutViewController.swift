//
//  abautViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 24-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MessageUI

class aboutViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate  {
    
    var companyAboutInfo: Company!
    var companyInfo:CompanyApp!
    var confVista: View!
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

        view.backgroundColor = UIColor (rgba: companyInfo.palette.color2 as String)
        self.title = self.companyAboutInfo.name as String
        
        detailEventView.toolBar.hidden = false
        detailEventView.toolBar.barTintColor = UIColor (rgba: companyInfo.palette.color4 as String)
        detailEventView.toolBar.tintColor = UIColor .whiteColor()
        
        var mutu = NSMutableArray()
        
//        let mobiFi = self.companyAboutInfo.headerImage
//        mobiFi.fetchFromLocalDatastoreInBackground()
//        if (mobiFi.isDataAvailable()) {
//            
//            let ima = mobiFi.parseFileV1 as PFFile
//            ima.getDataInBackgroundWithBlock({ (dataImagen:NSData!, error:NSError!) -> Void in
//                
//                if(error != nil){
//                    println(error)
//                    
//                }
//                else{
//                    
//                    let image = UIImage(data:dataImagen)
//                    self.detailEventView.imagen.image = image
//                    
//                    println(mobiFi.parseFileV1.name)
//                    
//                }
//                
//            })
//
//        } else {
//            
//            detailEventView.imagen.hidden = true
//            detailEventView.imagenHeight.constant = 0
//            
//        }


        detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 110)
        
        view.addSubview(detailEventView)
        
}
    //Métodos ToolaBar
    func phone(sender: UIBarButtonItem) {
        if let url = NSURL(string: "tel://\(companyAboutInfo.phone)") {
            UIApplication.sharedApplication().openURL(url)
            println(url)

        }
        
    }
    func mail(sender: UIBarButtonItem) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
}
    
    
    func web(sender: UIBarButtonItem) {
        println("weba")
        let storyboard = UIStoryboard(name: "Meeting", bundle: nil)
        let filesVC = storyboard.instantiateViewControllerWithIdentifier("filesViewController") as! filesViewController
        filesVC.urling = companyAboutInfo.website
        self.navigationController?.pushViewController(filesVC, animated: true)

    }


    override func viewDidLayoutSubviews() {
        
        if (detailEventView.tabla1.contentSize.height <= 20) {
            detailEventView.tabla1Height.constant = 0
        } else {
            detailEventView.tabla1Height.constant = detailEventView.tabla1.contentSize.height
        }
        
        detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
        detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
        
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
            
            return 0
        }
        if (tableView == detailEventView.tablaEvento) {
            
            return 0
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 80
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.companyAboutInfo.headerImage
            mobiFi.fetchFromLocalDatastoreInBackground()
            if (mobiFi.isDataAvailable()) {
                
                let ima = mobiFi.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)
                        
                    } else {
                        
                        let image = UIImage(data:dataImagen!)
                        cell.imageFull.image = image
                        
                        
                        println(mobiFi.parseFileV1.name)
                    }
                })
                
                heightImagen = self.view.frame.height * 0.25
                
            } else {
                
                cell.imageFull.hidden = true
                heightImagen = 0
                
            }
            
        }
        
        if (tableView == detailEventView.tablaHeader) {
            
            cell.textoLabel1 = self.companyAboutInfo.name
            
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
            cell.textoLabel2 = self.companyAboutInfo.details
            
        }
        
        if (companyAboutInfo.view.isDataAvailable()){
            heightImagen = 36
        } else {
            heightImagen = 0
        }

        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = cell.textoLabel1 as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = cell.textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0,cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoMediano
        label3.text = cell.textoLabel3 as String
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = cell.fontTextoMediano
        label4.text = cell.textoLabel4 as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = cell.fontTextoMediano
        label5.text = cell.textoLabel5 as String
        
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
            
            let mobiFi = self.companyAboutInfo.headerImage
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
        
            cell.backgroundColor = UIColor (rgba: companyInfo.palette.color4 as String)
            
            // Para centrar texto
            
            let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.viewInfo.frame.width, CGFloat.max))
            label1.numberOfLines = 0
            label1.lineBreakMode = cell.modoTerminoDeLinea
            label1.font = cell.fontTextoGrande
            label1.text = self.companyAboutInfo.name as String
            
            if (label1.frame.height >= 16) {
                cell.label1Top.constant = 25
            } else {
                cell.label1Top.constant = 35
            }
            
            //
            
            cell.label1.text = self.companyAboutInfo.name as String
            cell.label1.textColor = UIColor .whiteColor()
            cell.label1.font = cell.fontTextoGrande
            
            if !(self.companyAboutInfo.logo.parseFileV1.getData() == nil) {
                
                cell.imagen.backgroundColor = UIColor .whiteColor()
                cell.imagen.image = UIImage(data: self.companyAboutInfo.logo.parseFileV1.getData()!)
                cell.imagenTop.constant = 0
                cell.imagenBot.constant = 0
                cell.imagenHeight.constant = 90
                cell.imagenWidth.constant = 90
                cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                
            } else {
                
                cell.imagenWidth.constant = 0
                
            }
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
        
            cell.viewContentLeft.constant = 10
            cell.viewContentTop.constant = 5
            cell.viewContentRight.constant = 10
            cell.viewContentBot.constant = 5
            
            cell.label1.text = companyAboutInfo.details as String
            cell.label1.font = cell.fontTextoMediano
            cell.imagenWidth.constant = 0
            
            return cell
            
        }
            
        else if (tableView == detailEventView.tablaSpeaker){
            
            
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

        mailComposerVC.setToRecipients([companyAboutInfo.mail])
        
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