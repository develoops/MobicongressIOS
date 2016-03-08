//
//  StaffViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 23-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class StaffViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
        
        var tabla = UITableView()
    var staffInfo:CompanyApp!
        var mutuActor = NSMutableArray()
    var titleView : String!
    
    
        override func viewDidLoad() {
            
    for actore in self.staffInfo.hostedCompany.actors{
        if let actor = actore as? Actor{
            actor.fetchFromLocalDatastoreInBackground()
                mutuActor.addObject(actor)
                }
            }
            
            let color = self.staffInfo.palette as ColorPalette
            let nibName = UINib(nibName: "meetingCell", bundle:nil)
            self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
            
            self.tabla.delegate = self
            self.tabla.dataSource = self
            self.tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 118)
            
            self.view.addSubview(self.tabla)
            view.backgroundColor = UIColor (rgba: color.color2 as String)
            
            tabla.rowHeight = UITableViewAutomaticDimension
            tabla.backgroundColor = UIColor.clearColor()
            tabla.separatorColor = UIColor.clearColor()
            
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mutuActor.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen = 60 as CGFloat
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        let actor = mutuActor.objectAtIndex(indexPath.row) as! Actor
        if(actor.isDataAvailable()){
            actor.fetchFromLocalDatastoreInBackground()
        
        let persona = actor.person as Person
        if(persona.isDataAvailable()){
            cell.textoLabel1 = "\(persona.salutation) \(persona.firstName) \(persona.lastName)"
            
            var rolActor = self.staffInfo.hostedCompany.actors.objectAtIndex(indexPath.row) as! Actor
            cell.textoLabel2 = rolActor.charge
            }}
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = cell.textoLabel1  as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoPequeño
        label2.text = cell.textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoPequeño
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
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 15
        
        if (heightTexto > heightImagen) {
            height = heightTexto
        } else {
            height = heightImagen + 10
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell

        let actor = mutuActor.objectAtIndex(indexPath.row) as! Actor
        cell.viewContent.backgroundColor = UIColor .whiteColor()

        cell.viewContentLeft.constant = 5
        cell.viewContentTop.constant = 5
        cell.viewContentRight.constant = 5
        cell.label1Top.constant = 15
        cell.label5Bot.constant = 15
        
        if(actor.isDataAvailable()){
            actor.fetchFromLocalDatastoreInBackground()
        
        let persona = actor.person as Person
        
        if(persona.isDataAvailable()){
            persona.fetchFromLocalDatastoreInBackground()

            cell.separator.backgroundColor = UIColor.clearColor()
            cell.label1.text = "\(persona.salutation) \(persona.firstName) \(persona.lastName)"
            
            cell.label1.font = cell.fontTextoGrande
            
            var rolActor = self.staffInfo.hostedCompany.actors.objectAtIndex(indexPath.row) as! Actor
            
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            if(idioma == "es")
            {
                cell.label5.text = rolActor.charge as String!
                
            }
            else if(idioma == "en"){
                
                cell.label5.text = rolActor.charge as String!
            }
                
            else if(idioma == "pt"){
                
                cell.label5.text = rolActor.charge as String!
            }
                
            else{
                cell.label5.text = rolActor.charge as String!
                
            }
            
            cell.label5.font = cell.fontTextoPequeño
            
            cell.imagen.layer.cornerRadius = 50/2
            cell.imagen.clipsToBounds = true
            cell.imagenHeight.constant = 50
            cell.imagenWidth.constant = 50
        
            let profileFoto = persona.profileImage as MobiFile
            profileFoto.fetchFromLocalDatastoreInBackground()
            if (profileFoto.isDataAvailable()) {
                
                let ima = profileFoto.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({
                    (dataImagen, error) -> Void in
                    if(error != nil){
                        println(error)}
                    else{
                        
                        let image = UIImage(data:dataImagen!)
                        cell.imagen.image = image
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFill
                    }})
            }
            else {
            cell.imagen.image = UIImage (named: "speaker_nofoto")
            }}
        cell.imagenLeft.constant = 5
        cell.imagen.layer.cornerRadius = 50/2
        cell.imagen.clipsToBounds = true
        cell.imagenHeight.constant = 50
        cell.imagenWidth.constant = 50
    }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tabla.deselectRowAtIndexPath(indexPath, animated: true)
        
        let actor = mutuActor.objectAtIndex(indexPath.row) as! Actor
        let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("staffDetailViewController") as! staffDetailViewController
        detalle.actores = actor
        detalle.companyApp = staffInfo

        self.navigationController?.pushViewController(detalle, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.title = titleView
        
        self.tabla.reloadData()
    }
}
