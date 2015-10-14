//
//  staffDetailViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 3/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class staffDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource  {

    
    var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
    var actores:Actor!
    var companyApp:CompanyApp!
    
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
        
        // hidden hasta agregar view de toolBar
        
        detailEventView.toolBar.hidden = true
        detailEventView.toolBarHeight.constant = 0
    
        if (actores.person.bio.length != 0) {
    
        }
        
        detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 110)
        
        view.addSubview(detailEventView)
        
        view.backgroundColor = UIColor (rgba: companyApp.palette.color2 as String)
    
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        
        detailEventView.tabla1Height.constant = 0
        
        detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
        detailEventView.tablaConfHeaderHeight.constant = detailEventView.tablaConfHeader.contentSize.height
        detailEventView.tablaSpeakerHeight.constant = detailEventView.tablaSpeaker.contentSize.height
        detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
        detailEventView.tablaEventoHeight.constant = detailEventView.tablaEvento.contentSize.height
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
        var heightImagen:CGFloat = 90
        
        var textoLabel1 = String()
        var textoLabel2 = String()
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if (tableView == detailEventView.tablaHeader) {
            
            if(actores.person.isDataAvailable()){
                
                if actores.person.salutation == "" {
                    
                    textoLabel1 = "\(actores.person.firstName) \(actores.person.lastName)"
                    
                } else {
                    
                    textoLabel1 = "\(actores.person.salutation) \(actores.person.firstName) \(actores.person.lastName)"
                    
                }
            }
        }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
             if (actores.person.bio.length != 0){
                textoLabel2 = actores.person.bio as String
            }
        }
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = textoLabel1  as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width - 40, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
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
        
        if (tableView == detailEventView.tablaHeader) {
            
            let color = self.companyApp.palette as ColorPalette
            
            cell.backgroundColor = UIColor (rgba: color.color4 as String)
            cell.viewContent.backgroundColor = UIColor.clearColor()
            cell.viewInfo.backgroundColor = UIColor.clearColor()
            
            cell.label1Top.constant = 20
            cell.viewContentLeft.constant = 10
            cell.viewInfoLeft.constant = 5
            
            if(actores.person.isDataAvailable()){
                
                cell.separator.backgroundColor = UIColor.clearColor()
                
                if actores.person.salutation == "" {
                    
                    cell.label1.text = "\(actores.person.firstName) \(actores.person.lastName)"
                    
                } else {
                    
                    cell.label1.text = "\(actores.person.salutation) \(actores.person.firstName) \(actores.person.lastName)"
                    
                }
            
                cell.label1.textColor = UIColor.whiteColor()
            }
            
            if (actores.person.profileImage.isDataAvailable()) {
                
    let ima = actores.person.profileImage.parseFileV1 as PFFile
        ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
    
        if(error != nil){
        println(error)}
       
        else{
                        
            let image = UIImage(data:dataImagen!)
            cell.imagen.image = image
            }})
                
                cell.imagen.layer.cornerRadius = 90/2
                cell.imagen.contentMode = UIViewContentMode.ScaleAspectFill
                cell.imagen.clipsToBounds = true
                cell.imagenHeight.constant = 90
                cell.imagenWidth.constant = 90
                
                
            } else {
                cell.imagenWidth.constant = 0
            }
            return cell
            }
        
        if (tableView == detailEventView.tablaDescripcion) {
            
            cell.imagenWidth.constant = 0
            cell.separator.backgroundColor = UIColor .clearColor()
            
            cell.viewContentLeft.constant = 5
            cell.viewContentTop.constant = 10
            
            if (actores.person.bio.length != 0){
                cell.label1.text = actores.person.bio as String
                cell.label1.font = cell.fontTextoMediano
                
            }
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
    
    
}
