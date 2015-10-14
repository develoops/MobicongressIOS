//
//  expositoresDetalleViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 3/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class expositoresDetalleViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
    var persona:Person!
    var evento:MeetingApp!
    
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
        
        if (persona.bio.length != 0) {
        }
        
        detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 110)
        detailEventView.backgroundColor = UIColor (rgba: evento.palette.color2 as String)
        
        view.addSubview(detailEventView)
        
        detailEventView.toolBar.barTintColor = UIColor (rgba: evento.palette.color4 as String)
        detailEventView.toolBar.tintColor = UIColor .whiteColor()
        
        var mutu = NSMutableArray()
        if(persona.view.isDataAvailable()){
            let visti = persona.view as View
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
            detailEventView.toolBarHeight.constant = 0
        }
        
    }
    
    
    func funPhone(sender: UIBarButtonItem) {
        println("tele")
      
    }
    func funMail(sender: UIBarButtonItem) {
        println("mail")

    }
    func funWeb(sender: UIBarButtonItem) {
        println("weba")
        
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

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
        detailEventView.tablaConfHeaderHeight.constant = 0
        detailEventView.tablaSpeakerHeight.constant = 0
        
        if !(persona.bio.length == 0) {
            detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
        } else {
            detailEventView.tablaDescripcionHeight.constant = 0
        }
        
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
            
            let eventos = NSMutableArray()
            for acto in persona.actors{
                if let a = acto as? Actor{
                a.fetchFromLocalDatastoreInBackground()
                for even in a.events{
                    if(even.isDataAvailable()){
                        even.fetchFromLocalDatastoreInBackground()

                    eventos.addObject(even as! Event)
                    }}
                }
            }

            return eventos.count ?? 0
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        var textoLabel1 = "" as NSString!
        var textoLabel2 = "" as NSString!
        var textoLabel3 = "" as NSString!
        var textoLabel4 = "" as NSString!
        var textoLabel5 = "" as NSString!
        var formatoLabel1 = UIFont(name: "ArialMT", size: 13) as UIFont!
        var formatoLabel2 = UIFont(name: "ArialMT", size: 13) as UIFont!
        var formatoLabel3 = UIFont(name: "ArialMT", size: 13) as UIFont!
        var formatoLabel4 = UIFont(name: "ArialMT", size: 13) as UIFont!
        var formatoLabel5 = UIFont(name: "ArialMT", size: 13) as UIFont!
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 90
        var lugarString:NSString!
        
        var sumaAlHeight = 20 as CGFloat
        
        if (tableView == detailEventView.tablaHeader) {
            
            if(persona.isDataAvailable()){
                
                if persona.salutation == "" {
                    
                    textoLabel1 = "\(persona.firstName) \(persona.lastName)"
                    
                } else {
                    
                    textoLabel1 = "\(persona.salutation) \(persona.firstName) \(persona.lastName)"
                    
                }
                
                
            }
        }
        
        if (tableView == detailEventView.tablaDescripcion)
        {
            if(persona.bio.length != 0){
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoLabel2 = persona.bio
                    
                }
                else if(idioma == "en"){
                    
                    textoLabel2 = persona.bioLg2
                }
                    
                else if(idioma == "pt"){
                    
                    textoLabel2 = persona.bioLg3
                }
                    
                else{
                    textoLabel2 = persona.bio
                    
                }
        
            }
                
            else{
            textoLabel2 = ""
            }
            heightImagen = 0

        }
            
        else if (tableView == detailEventView.tablaEvento) {
            let eventos = NSMutableArray()
            for acto in persona.actors{
                let a = acto as! Actor
                for even in a.events{
                    eventos.addObject(even as! Event)
                }
            }
            
            let event =  eventos.objectAtIndex(indexPath.row) as! Event
            
            let strMutu = NSMutableString()
            var lugarString:NSString!
            var sumaAlHeight = 20 as CGFloat
            if (event.place.isDataAvailable()){
                let lug = event.place as Place
                lug.fetchFromLocalDatastoreInBackground()
                if(lug.name.length != 0){
                lugarString = lug.name as NSString
                }
                    else{
                
            lugarString = ""
                }}
            var diaEventoString = MCDateFormatter().DiayMes().stringFromDate(event.startDate)
            var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(event.startDate)
            var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(event.endDate)
            //*******************************arreglar esta huea pal offline*******************************//
            
            event.fetchFromLocalDatastoreInBackground()
            if(event.actors.count != 0){
                var o = NSMutableArray(array: event.actors)
                for cadaHuea in o {
                    if(cadaHuea.isKindOfClass(NSNull)){
                        o.removeObject(cadaHuea)
                    }
                }
                
            var personaUno = o.firstObject as! Actor
            personaUno .fetchFromLocalDatastoreInBackground()
                if personaUno.person.isDataAvailable() {
                    
                    var strUno = String()
                    
                    if personaUno.person.salutation == "" {
                        
                        strUno = "\(personaUno.person.firstName) \(personaUno.person.lastName)"
                    } else {
                        
                        strUno = "\(personaUno.person.salutation) \(personaUno.person.firstName) \(personaUno.person.lastName)"
                        
                    }
                    
                    strMutu.appendString(strUno)
                }
                
                for var index = 1; index < o.count; ++index {
                    
                    let per = o.objectAtIndex(index) as! Actor
                    per.fetchFromLocalDatastoreInBackground()
                    
                    if(per.person.isDataAvailable()){
                        
                        var strDos = String()
                        
                        if per.person.salutation == "" {
                            
                            strDos = "\n\(per.person.firstName) \(per.person.lastName)"
                            
                        } else {
                            
                            strDos = "\n\(per.person.salutation) \(per.person.firstName) \(per.person.lastName)"
                            
                        }
                        
                        strMutu.appendString(strDos)
                    }}}
            
            if (event.icon.isDataAvailable()){
                heightImagen = 70
            } else {
                heightImagen = 0
            }
            
            textoLabel1 = event.realTitulo()
            textoLabel2 = lugarString
            textoLabel3 = "\(horaInicioString) - \(horaFinString)"
            textoLabel4 = strMutu
            
            formatoLabel1 = UIFont(name: "Arial-BoldMT", size: 15)
            formatoLabel2 = UIFont(name: "ArialMT", size: 14)
            formatoLabel3 = UIFont(name: "ArialMT", size: 14)
            formatoLabel4 = UIFont(name: "ArialMT", size: 14)
            
            sumaAlHeight = 20
            
        }
    

        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = formatoLabel1
        label1.text = textoLabel1 as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = formatoLabel2
        label2.text = textoLabel2 as? String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = formatoLabel3
        label3.text = textoLabel3 as String
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = formatoLabel4
        label4.text = textoLabel4 as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = formatoLabel5
        label5.text = textoLabel5 as String
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        label4.sizeToFit()
        label5.sizeToFit()
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + sumaAlHeight
        
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

            let color = evento.palette as ColorPalette
            
            cell.backgroundColor = UIColor (rgba: color.color4 as String)
            cell.viewContent.backgroundColor = UIColor.clearColor()
            cell.viewInfo.backgroundColor = UIColor.clearColor()
            
            cell.label1Top.constant = 20
            cell.viewContentLeft.constant = 10
            cell.viewInfoLeft.constant = 5
            
            if(persona.isDataAvailable()){
                
                cell.separator.backgroundColor = UIColor.clearColor()
                
                if persona.salutation == "" {
                    
                    cell.label1.text = "\(persona.firstName) \(persona.lastName)"
                    
                } else {
                    
                    cell.label1.text = "\(persona.salutation) \(persona.firstName) \(persona.lastName)"
                    
                }
                
                cell.label1.textColor = UIColor.whiteColor()
            }
            
            if (persona.profileImage.isDataAvailable()) {
                
                let ima = persona.profileImage.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)}
                        
                    else{
                        
                        let image = UIImage(data:dataImagen!)
                        cell.imagen.image = image
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFill
                    }})

                
                cell.imagen.layer.cornerRadius = 90/2
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
            
            cell.viewContentLeft.constant = 5
            cell.viewContentTop.constant = 5
            cell.viewContentBot.constant = 5
            cell.viewContentRight.constant = 5
            
            if(persona.bio.length != 0){
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    cell.label1.text = persona.bio as String
                    
                }
                else if(idioma == "en"){
                    
                    cell.label1.text = persona.bioLg2 as String
                }
                    
                else if(idioma == "pt"){
                    
                    cell.label1.text = persona.bioLg3 as String
                }
                    
                else{
                    cell.label1.text = persona.bio as String
                    
                }
                cell.label1.font = UIFont(name: "ArialMT", size: 13)
      
            }
            return cell
            
        }
            
        else if (tableView == detailEventView.tablaSpeaker){
            
            return cell
        }
            
        else if (tableView == detailEventView.tablaEvento) {
            
            let eventos = NSMutableArray()
            for acto in persona.actors{
                let a = acto as! Actor
                for even in a.events{
                    eventos.addObject(even as! Event)
                }
        }
            let event =  eventos.objectAtIndex(indexPath.row) as! Event
            
            let palette = event.palette as ColorPalette
            palette.fetchFromLocalDatastoreInBackground()
            cell.backgroundColor = UIColor (rgba: palette.color1 as String)
            
            cell.viewContent.backgroundColor = UIColor .whiteColor()
            cell.viewInfo.backgroundColor = UIColor .whiteColor()
            cell.separator.backgroundColor = UIColor .whiteColor()
            
            cell.viewContentLeft.constant = 14
            cell.viewContentBot.constant = 4
            
            var lugarString = NSString()
            let strMutu = NSMutableString()
            
            if(event.actors.count != 0){
                var o = NSMutableArray(array: event.actors)
                for cadaHuea in o {
                    if(cadaHuea.isKindOfClass(NSNull)){
                        o.removeObject(cadaHuea)
                    }
                }
                
                var personaUno = o.firstObject as! Actor
                personaUno.fetchFromLocalDatastoreInBackground()
                if personaUno.person.isDataAvailable() {
                    
                    var strUno = String()
                    
                    if personaUno.person.salutation == "" {
                        
                        strUno = "\(personaUno.person.firstName) \(personaUno.person.lastName)"
                    } else {
                        
                        strUno = "\(personaUno.person.salutation) \(personaUno.person.firstName) \(personaUno.person.lastName)"
                        
                    }
                    
                    strMutu.appendString(strUno)
                }
       
            for var index = 1; index < o.count; ++index {
                    let per = o.objectAtIndex(index) as! Actor
                    per.fetchFromLocalDatastoreInBackground()
                    if(per.person.isDataAvailable()){
                        
                        var strDos = String()
                        
                        if per.person.salutation == "" {
                            
                            strDos = "\n\(per.person.firstName) \(per.person.lastName)"
                            
                        } else {
                            
                            strDos = "\n\(per.person.salutation) \(per.person.firstName) \(per.person.lastName)"
                            
                        }
                        
                        strMutu.appendString(strDos)
            }}}
            
            var diaEventoString = MCDateFormatter().DiayMes().stringFromDate(event.startDate)
            var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(event.startDate)
            var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(event.endDate)
            
            if (event.place.isDataAvailable()){
                lugarString = event.place.name as NSString
            }
            
            cell.label1.text = event.realTitulo() as String
            cell.label2.text = lugarString as String
            cell.label4.text = "\(horaInicioString) - \(horaFinString)"
            cell.label5.text = strMutu as String
            
            cell.label1.textColor = UIColor .darkGrayColor()
            cell.label1.font = UIFont(name: "Arial-BoldMT", size: 15)
            cell.label2.textColor = UIColor .darkGrayColor()
            cell.label2.font = UIFont(name: "ArialMT", size: 14)
            cell.label4.textColor = UIColor .darkGrayColor()
            cell.label4.font = UIFont(name: "ArialMT", size: 14)
            cell.label5.textColor = UIColor .darkGrayColor()
            cell.label5.font = UIFont(name: "ArialMT", size: 14)
            
            if (event.icon.isDataAvailable()) {
                
                event.icon.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                    
                    if(error != nil){
                        cell.imagenWidth.constant = 0

                    }
                    else{
                        cell.imagen.image = UIImage(data:datata!)
                        cell.imagenWidth.constant = 70
                        cell.imagenHeight.constant = 70

                    }
                })
            }
            else {
                cell.imagenWidth.constant = 0
            }
        cell .setNeedsDisplay()
        cell .layoutIfNeeded()
    }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        detailEventView.tablaEvento.deselectRowAtIndexPath(indexPath, animated: true)
        
        let eventos = NSMutableArray()
        for acto in persona.actors{
            let a = acto as! Actor
            for even in a.events{
                eventos.addObject(even as! Event)
            }
        }
        let event =  eventos.objectAtIndex(indexPath.row) as! Event
        let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("detalleViewController") as! detalleViewController
        detalle.evento = event
        detalle.meetingApp = evento
        self.navigationController?.pushViewController(detalle, animated: true)
        
    }

}
