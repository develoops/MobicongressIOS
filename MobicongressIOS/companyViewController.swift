//
//  companyViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 3/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MessageUI

class companyViewController: UIViewController,  UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    var companyAboutInfo: Facade!
    var companyInfo:CompanyApp!
    var confVista: View!
    var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
    var titleView : String!
    
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
        detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 108)
        view.addSubview(detailEventView)
        
        
        detailEventView.toolBar.barTintColor = UIColor (rgba: companyInfo.palette.color4 as String)
        detailEventView.toolBar.tintColor = UIColor .whiteColor()
        
        var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        var titlePhone = "" as String
        var titleMail = "" as String
        var titleWeb = "" as String
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            titlePhone = "Llamar"
            titleMail = "Mail"
            titleWeb = "Web"
            
        }
        else if(idioma == "en"){
            
            titlePhone = "Call"
            titleMail = "Mail"
            titleWeb = "Web"
            
        }
            
        else if(idioma == "pt"){
            
            titlePhone = "Chamada"
            titleMail = "Correio"
            titleWeb = "Teia"
            
        }
            
        else{

            titlePhone = "Llamar"
            titleMail = "Mail"
            titleWeb = "Web"
            
        }
        
        
        var item1 = UIBarButtonItem(title: titlePhone as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funPhone:")
        var item2 = UIBarButtonItem(title: titleMail as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funMail:")
        var item3 = UIBarButtonItem(title: titleWeb as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funWeb:")
        
        detailEventView.toolBar.items = [flexibleSpace,item1,flexibleSpace,item2,flexibleSpace,item3,flexibleSpace]
        detailEventView.toolBar.hidden = false

    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = titleView

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
        
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            
            filesVC.texto = "Cargando sitio web de \(companyAboutInfo.company.name)"
            
            
        }
        else if(idioma == "en"){
            
            
            filesVC.texto = "Loading \(companyAboutInfo.company.name)'s website"
            
        }
            
        else if(idioma == "pt"){
            
            filesVC.texto = "Carregando website \(companyAboutInfo.company.name)"
            
        }
            
        else{
            
            filesVC.texto = "Cargando sitio web de \(companyAboutInfo.company.name)"
            
        }
        
        
        
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
        
        if (tableView == detailEventView.tabla1) {
            return 1
        }
        if (tableView == detailEventView.tablaConfHeader) {
            
            return 0
        }
        if (tableView == detailEventView.tablaHeader) {
            
            return 1
        }
        if (tableView == detailEventView.tablaSpeaker) {
            
            return 0
        }
        if (tableView == detailEventView.tablaDescripcion) {
            
            return 1
        }
        if (tableView == detailEventView.tablaEvento) {
            
            return 0
        }

        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        if (tableView == detailEventView.tabla1) {
            return 1
        }
        if (tableView == detailEventView.tablaConfHeader) {
            
            return 0
        }
        if (tableView == detailEventView.tablaHeader) {
            
            return 1
        }
        if (tableView == detailEventView.tablaSpeaker) {
            
            return 0
        }
        if (tableView == detailEventView.tablaDescripcion) {
            
            return 1
        }
        if (tableView == detailEventView.tablaEvento) {
            
            return 0
        }
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat!
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.companyAboutInfo.company.headerImage
            mobiFi.fetchFromLocalDatastoreInBackground()
            if (mobiFi.isDataAvailable()) {
                
                heightImagen = self.view.frame.height * 0.2
                
            } else {
                
                cell.imageFull.hidden = true
                heightImagen = 0
                
            }
            
        }
        
        if (tableView == detailEventView.tablaHeader) {
                        
            cell.textoLabel1 = self.companyAboutInfo.company.name
            heightImagen = 80
            
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            if(idioma == "es")
            {
                cell.textoLabel2 = self.companyAboutInfo.company.details
                
            }
            else if(idioma == "en"){
                
                cell.textoLabel2 = self.companyAboutInfo.company.details
            }
                
            else if(idioma == "pt"){
                
                cell.textoLabel2 = self.companyAboutInfo.company.details
            }
                
            else{
                cell.textoLabel2 = self.companyAboutInfo.company.details
                
            }
            
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
        label2.text = cell.textoLabel2  as? String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0,cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoMediano
        label3.text = cell.textoLabel3  as String
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = cell.fontTextoMediano
        label4.text = cell.textoLabel4  as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = cell.fontTextoMediano
        label5.text = cell.textoLabel5  as String
        
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
                                                
                    }})
            
                
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
            
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            if(idioma == "es")
            {
                label1.text = self.companyAboutInfo.company.name as String
                
            }
            else if(idioma == "en"){
                
                label1.text = self.companyAboutInfo.company.name as String
            }
                
            else if(idioma == "pt"){
                
                label1.text = self.companyAboutInfo.company.name as String
            }
                
            else{
                label1.text = self.companyAboutInfo.company.name as String
                
            }
            
            
            if (label1.frame.height >= 16) {
                cell.label1Top.constant = 25
            } else {
                cell.label1Top.constant = 35
            }
            
            //
            
            if(idioma == "es")
            {
                cell.label1.text = self.companyAboutInfo.company.name as String
                
            }
            else if(idioma == "en"){
                
                cell.label1.text = self.companyAboutInfo.company.name as String
            }
                
            else if(idioma == "pt"){
                
                cell.label1.text = self.companyAboutInfo.company.name as String
            }
                
            else{
                cell.label1.text = self.companyAboutInfo.company.name as String
                
            }
            
            
            cell.label1.textColor = UIColor .whiteColor()
            cell.label1.font = cell.fontTextoGrande
            
            self.companyAboutInfo.company.logo.parseFileV1.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
                
                if(error != nil){
                
                }
                else{
                
                    if (data != nil) {
                        
                        cell.imagen.backgroundColor = UIColor .whiteColor()
                        cell.imagen.image = UIImage(data: data!)
                        cell.imagenTop.constant = 0
                        cell.imagenBot.constant = 0
                        cell.imagenHeight.constant = 90
                        cell.imagenWidth.constant = 90
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                        
                    } else {
                        cell.imagenWidth.constant = 0
                    }

                }
            })
                    }
        
        if (tableView == detailEventView.tablaDescripcion) {
            let color = self.companyInfo.palette as ColorPalette
        
            cell.viewContentLeft.constant = 10
            cell.viewContentTop.constant = 5
            cell.viewContentRight.constant = 10
            cell.viewContentBot.constant = 5
            
            
            if !(companyAboutInfo.company.details.length == 0) {
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    cell.label1.text = self.companyAboutInfo.company.details as String
                    
                }
                else if(idioma == "en"){
                    
                    cell.label1.text = self.companyAboutInfo.company.details as String
                }
                    
                else if(idioma == "pt"){
                    
                    cell.label1.text = self.companyAboutInfo.company.details as String
                }
                    
                else{
                    cell.label1.text = self.companyAboutInfo.company.details as String
                    
                }
        
                cell.label1.font = cell.fontTextoMediano
                
            } else {
                
                cell.label1.text = ""
            }
            
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