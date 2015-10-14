//
//  detalleViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 27-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.

import UIKit

class detalleViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
    var evento:Event!
    var meetingApp:MeetingApp!
    var eventoSup:Event!
    var tieneEventoSup:Bool = false
    var acFavorito:UILabel!
    var predicaoDia:NSPredicate!
    var anidaosFiltraos = NSArray()
    var ratiFav:Rating!
    var defolto = NSUserDefaults()
    let device = Device()

    override func viewWillAppear(animated: Bool) {
        detailEventView.tablaEvento.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkFav()
        if(predicaoDia != nil){
            self.anidaosFiltraos = self.evento.anidateEvents.filteredArrayUsingPredicate(predicaoDia)
        }
        else{
        self.anidaosFiltraos = self.evento.anidateEvents
        }

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
        detailEventView.tablaConfHeader.delegate = self
        detailEventView.tablaConfHeader.dataSource = self
        
        detailEventView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height - 110)
        detailEventView.backgroundColor = UIColor (rgba: meetingApp.palette.color2 as String)
        detailEventView.toolBar.barTintColor = UIColor (rgba: meetingApp.palette.color4 as String)
        detailEventView.toolBar.tintColor = UIColor .whiteColor()

        view.addSubview(detailEventView)
        
        
        detailEventView.tablaEventoLeft.constant = 10
        detailEventView.tablaEventoRight.constant = 10
        detailEventView.tablaEventoTop.constant = 5
        detailEventView.tablaEventoBot.constant = 5
    }

   
    func funRoomEvent(sender: UIBarButtonItem) {
        println("anda a mapa")
        
    var mapaVc = self.storyboard?.instantiateViewControllerWithIdentifier("mapaViewController") as! mapaViewController
       
        mapaVc.mapaInfo = evento.place
        
        var mutuMapas = NSMutableArray()
        
        mapaVc.puntoX = evento.place.x
        mapaVc.puntoY = evento.place.y
        
            for obje in evento.place.maps{
            if let mapa = obje as? MobiFile{

                if(mapa.isDataAvailable()){
                    
                    mapa.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                    
                        if(error != nil){
                        }
                        else{
                        let mapaImagen = UIImage(data:datata!)
                        mutuMapas.addObject(mapaImagen!)
                        mapaVc.planoImagen = mutuMapas.firstObject as? UIImage
                            
                        self.navigationController?.pushViewController(mapaVc, animated: true)

                        }
                })

                }
                else{
                
                    sender.title = ""
                    
                }
            }
        }
    }
    
    func funFavorite(sender: UIBarButtonItem) {
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        
        if(defolto.boolForKey("fav") == true){
            self.eliminaFav()
            
            if(idioma == "es")
            {

//                          sender.title = "Favorito"
                            sender.title = "Favorite"
                
            }
            else if(idioma == "en"){
                

                            sender.title = "Favorite"
            }
                
            else if(idioma == "pt"){
                
                            sender.title = "Favorito"

            }
                
            else{

                sender.title = "Favorito"
                
            }
            

            detailEventView.tablaHeader.reloadData()
            defolto.setBool(false, forKey: "fav")
        }
            
        else {
            
           
            
            if(defolto.boolForKey("listo") || defolto.boolForKey("local")){
                self.guardaFav()
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("aparecerAvisoFavorito"), userInfo: nil, repeats: false)
                detailEventView.tablaHeader.reloadData()
                
                
                if(idioma == "es")
                {
                    
//                sender.title = "Remover Fav"
                    sender.title = "UnFavorite"
                    
                }
                else if(idioma == "en"){
                    
                    
                    sender.title = "UnFavorite"
                }
                    
                else if(idioma == "pt"){
                    
                sender.title = "Remover Fav"
                    
                }
                    
                else{
                    
                    
                    sender.title = "Remover Fav"
                    
                }
                

                defolto.setBool(true, forKey: "fav")
            }
        }
        defolto.synchronize()
    }
    
    func tituloFav() -> NSString
        
        {
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            
            if(defolto.boolForKey("fav") == true){
                
                if(idioma == "es")
                {
                    
                    //                sender.title = "Remover Fav"
                    return "UnFavorite"
                    
                }
                else if(idioma == "en"){
                    
                    
                    return "UnFavorite"
                }
                    
                else if(idioma == "pt"){
                    
                    return "Remover Fav"
                    
                }
                    
                else{
                    
                    return  "Remover Fav"
                    
                }
        
            } else {
                
                if(idioma == "es")
                {
                    
                    //                          sender.title = "Favorito"
                    return "Favorite"
                    
                }
                else if(idioma == "en"){
                    
                    
                    return "Favorite"
                }
                    
                else if(idioma == "pt"){
                    
                    return "Favorito"
                    
                }
                    
                else{
                    
                    return "Favorito"
                    
                }
                
        }
    }
    func checkFav() {
        let user = PFUser.currentUser()!
        let quer = Rating.query()
        quer!.fromLocalDatastore()
        quer!.whereKey("user", equalTo:user)
        quer!.whereKey("type", equalTo:"fav")
        quer!.whereKey("event", equalTo: evento)
        
        quer!.findObjectsInBackground().continueWithBlock({
            (task: BFTask!) -> AnyObject! in
            if task.error != nil {
                println(task.error)
                
                return task
            }
            else
            {
                if(task.result.count == 0){
                    self.defolto.setBool(false, forKey: "fav")
                    println("niunaHuea")
                }
                else{
                    self.ratiFav = task.result.firstObject as! Rating
                    self.defolto.setBool(true, forKey: "fav")
                    
                    println("existe")
                }}
            var mutu = NSMutableArray()
            if(self.evento.view.isDataAvailable()){
                let visti = self.evento.view as View
                visti.fetchFromLocalDatastoreInBackground()
                
                for t in visti.toolBar as NSArray{
                    let contar = visti.toolBar.count
                    
                    if let tab = t as? Tool{
                        tab.fetchFromLocalDatastoreInBackground()
                        
                        let fun = (tab.toolName as String) + ":"
                        var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
                        mutu.addObject(flexibleSpace)
                        var titulo = tab.text
                        
                        if(tab.toolName == "funFavorite"){
                            titulo = self.tituloFav()
                        }
                        
                        else {
                            
                        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                        if(idioma == "es")
                        {
                            titulo = tab.text
                            
                        }
                        else if(idioma == "en"){
                            
                            titulo = tab.textLg2
                        }
                            
                        else if(idioma == "pt"){
                            
                            titulo = tab.textLg3
                        }
                            
                        else{
                            titulo = tab.text
                        }
                        }
                        
                     // LOL
                        
                        var item = UIBarButtonItem(title:titulo as String, style: UIBarButtonItemStyle.Plain, target: self, action:NSSelectorFromString(fun))
                        item.width = (self.view.frame.width / CGFloat(contar))
                        mutu.addObject(item)
                        
                    }
                }
                self.detailEventView.toolBar.items = mutu as [AnyObject]
                self.detailEventView.toolBar.hidden = false
            } else {
                self.detailEventView.toolBar.hidden = true
                self.detailEventView.toolBarHeight.constant = 0
            }

            
            self.defolto.synchronize()
            return task
        })}
    
    func guardaFav(){
        var rating = Rating()
        rating.type = "fav"
        rating.event = evento
        rating.user = PFUser.currentUser()!
        rating.comment = evento.title
        
        rating.pinInBackground()
    }
    
    func eliminaFav(){
        
        if var a = ratiFav{
            ratiFav.unpinInBackground()
        }
    }
       func funRating(sender: UIBarButtonItem) {
        
        if(Reachability.reachabilityForInternetConnection().currentReachabilityString == "No Connection")
        {
            let alertView = UIAlertView(title: "Sorry", message: "To access the function assessment must be connected to a network of Internet", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
        }
        else{

        let ratVC = self.storyboard?.instantiateViewControllerWithIdentifier("ratingViewController") as! ratingViewController
        
        ratVC.eventoId = evento
            self.navigationController?.pushViewController(ratVC, animated: true)
        }
        
        println("vamo a rating")
    }

    func funDocs(sender: UIBarButtonItem) {
        

    let filesVC = self.storyboard?.instantiateViewControllerWithIdentifier("libraryViewController") as! libraryViewController
        
        filesVC.meetingLibrary = self.evento.library

        self.navigationController?.pushViewController(filesVC, animated: true)
        
        println("vamo a Docs")
    }

    

        //manda a news

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if (detailEventView.tabla1.contentSize.height <= 20) {
            detailEventView.tabla1Height.constant = 0
        } else {
            detailEventView.tabla1Height.constant = detailEventView.tabla1.contentSize.height
        }
        
        detailEventView.tablaEventoHeight.constant = detailEventView.tablaEvento.contentSize.height
        
        detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
        
        if (tieneEventoSup == true) {
            detailEventView.tablaConfHeaderHeight.constant = detailEventView.tablaConfHeader.contentSize.height
        } else {
            detailEventView.tablaConfHeaderHeight.constant = 0
        }

        if (evento.details.length == 0) {
            detailEventView.tablaDescripcionHeight.constant = 0
        }else {
            detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
        }
        
        if (evento.actors.count == 0) {
            detailEventView.tablaSpeakerHeight.constant = 0
            detailEventView.tablaSpeaker.hidden = true
        } else {
            detailEventView.tablaSpeakerHeight.constant = detailEventView.tablaSpeaker.contentSize.height
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if (tableView == detailEventView.tablaSpeaker) {
            
            return evento.actors.count ?? 0
            
        }
        
        if (tableView == detailEventView.tablaEvento) {
            
            return self.anidaosFiltraos.count ?? 0
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var textoLabel1 = "" as NSString!
        var textoLabel2 = "" as NSString!
        var textoLabel3 = "" as NSString!
        var textoLabel4 = "" as NSString!
        var textoLabel5 = "" as NSString!
        var formatoLabel1:UIFont!
        var formatoLabel2:UIFont!
        var formatoLabel3:UIFont!
        var formatoLabel4:UIFont!
        var formatoLabel5:UIFont!
        
        var sumaAlHeight = 20 as CGFloat
        var lugarString:NSString!
        var descripcionString:NSString!
        var heightImagen:CGFloat!
        var widthCell:CGFloat!
        var hayImagen = Bool()
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue <= 8) {
            
            widthCell = cell.viewInfo.frame.width - 20
            
        } else {
            
            widthCell = view.frame.width - 20
        }
        
        var diaEventoString = MCDateFormatter().DiayMes().stringFromDate(evento.startDate)
        var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(evento.startDate)
        var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(evento.endDate)
        
        // Header si es Evento Anidado
        
        if (tieneEventoSup == true) {
        
            if (tableView == detailEventView.tablaConfHeader) {
                
                let icono = eventoSup.icon as MobiFile
                icono.fetchFromLocalDatastoreInBackground()
                if (icono.isDataAvailable()){
                    heightImagen = 90
                } else {
                    heightImagen = 0
                }
            
                // label1
                
                textoLabel1 = eventoSup.realTitulo() as NSString
                formatoLabel1 = cell.fontTextoNegrita
                
                // label2
                
                if (evento.place.isDataAvailable() || eventoSup.place.isDataAvailable()){
                    
                    if (eventoSup.place.name == evento.place.name) {
                        textoLabel2 = ""
                    } else if (eventoSup.place.name.length == 0) {
                        textoLabel2 = ""
                    } else {
                        textoLabel2 = evento.place.name
                        formatoLabel2 = cell.fontTextoMediano
                    }
                }
            
                // label3
                
                if (self.fechaDia(eventoSup.startDate) == self.fechaDia(evento.startDate)) {
                    textoLabel3 = ""
                } else {
                    textoLabel3 = self.fechaDia(eventoSup.startDate)
                    formatoLabel3 = cell.fontTextoMediano
                }
                
                // label4
            
                textoLabel4 = "\(self.fechaHoraStr(eventoSup.startDate)) - \(self.fechaHoraStr(eventoSup.endDate))"
                formatoLabel4 = cell.fontTextoMediano

                sumaAlHeight = 10
            
            }
            
            if (tableView == detailEventView.tablaHeader) {
                
                if (evento.icon.isDataAvailable()){
                    heightImagen = 90
                } else {
                    heightImagen = 0
                }
            
                textoLabel1 = self.evento.realTitulo() as NSString
                formatoLabel1 = cell.fontTextoNegrita
                    
                let lugare = evento.place
                if(lugare.isDataAvailable()){
                    lugare.fetchFromLocalDatastoreInBackground()
                        
                    if (lugare.name.length != 0){
                        textoLabel2 = lugare.name as String
                        formatoLabel2 = cell.fontTextoMediano
                    }
                }
                    
                textoLabel3 = self.fechaDia(evento.startDate)
                formatoLabel3 = cell.fontTextoMediano
                
                textoLabel4 = "\(self.fechaHoraStr(evento.startDate)) - \(self.fechaHoraStr(evento.endDate))"
                formatoLabel4 = cell.fontTextoMediano

                sumaAlHeight = 10
            
            }
        }
        
        // Header Evento Normal

        if (tableView == detailEventView.tablaHeader) {
            
            if (evento.icon.isDataAvailable()){
                heightImagen = 90
            } else {
                heightImagen = 0
            }
            
            textoLabel1 = self.evento.realTitulo() as NSString
            formatoLabel1 = cell.fontTextoNegrita
        
            
            let lugare = evento.place
            if(lugare.isDataAvailable()){
                lugare.fetchFromLocalDatastoreInBackground()
                
                if (lugare.name.length != 0){
                    textoLabel2 = lugare.name as String
                    formatoLabel2 = cell.fontTextoMediano
                }
            }
            
            textoLabel3 = diaEventoString
            formatoLabel3 = cell.fontTextoMediano
            
            textoLabel4 = "\(horaInicioString) - \(horaFinString)"
            formatoLabel4 = cell.fontTextoMediano
            
            sumaAlHeight = 10
            
        }
        
        if (tableView == detailEventView.tablaSpeaker){
            
        if (evento.actors.count != 0){
                var o = self.sacaNullActor(evento.actors)
                for var index = 0; index < o.count; ++index {
                    
                    let actorete = o.objectAtIndex(index) as! Actor
                    if(actorete.isDataAvailable()){
                    if(actorete.person.isDataAvailable()){
                        
                        if actorete.person.salutation == "" {
                            
                            textoLabel1 = "\(actorete.person.firstName) \(actorete.person.lastName)"
                            
                            
                        } else {
                            
                            textoLabel1 = "\(actorete.person.salutation) \(actorete.person.firstName) \(actorete.person.lastName)"
                    
                        }
                        
                        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                        if(idioma == "es")
                        {
                            textoLabel2 = actorete.charge
                            
                        }
                        else if(idioma == "en"){
                            
                            textoLabel2 = actorete.chargeLg2
                        }
                            
                        else if(idioma == "pt"){
                            
                            textoLabel2 = actorete.chargeLg3
                        }
                            
                        else{
                            textoLabel2 = actorete.charge
                            
                        }
                    
                        formatoLabel1 = cell.fontTextoMediano
                        formatoLabel2 = cell.fontTextoMediano
                        heightImagen = 40
                    }
                    sumaAlHeight = 5
            }}
        }
    }

        if (tableView == detailEventView.tablaDescripcion) {
            
            formatoLabel1 = cell.fontTextoMediano
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            if(idioma == "es")
            {
                textoLabel1 = evento.details
                
            }
            else if(idioma == "en"){
                
                textoLabel1 = evento.detailsLg2
            }
                
            else if(idioma == "pt"){
                
                textoLabel1 = evento.detailsLg3
            }
                
            else{
                textoLabel1 = evento.details
                
            }
            
            heightImagen = 0
            sumaAlHeight = 20
            
        }
        
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.evento.headerImage
            mobiFi.fetchFromLocalDatastoreInBackground()
            if (mobiFi.isDataAvailable()) {
                
                heightImagen = self.view.frame.height * 0.25
                
            } else {
                
                cell.imageFull.hidden = true
                heightImagen = 0
                
            }
            
        }
        
        if (tableView == detailEventView.tablaEvento) {
            
            
            
            if (evento.anidateEvents.count != 0) {
            
            var eventoAnidao = self.anidaosFiltraos.objectAtIndex(indexPath.row) as! Event
            let strMutu = NSMutableString()
                
                if (eventoAnidao.icon.isDataAvailable()){
                    hayImagen =  true
                } else {
                    hayImagen = false
                    
                }
            
            var diaEventoString = MCDateFormatter().DiayMes().stringFromDate(eventoAnidao.startDate)
            var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(eventoAnidao.startDate)
            var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(eventoAnidao.endDate)
            
  
            
            textoLabel1 = eventoAnidao.realTitulo()
                
                let lugare = eventoAnidao.place
                
                if(lugare.isDataAvailable()){
                    lugare.fetchFromLocalDatastoreInBackground()
                    if (lugare.name.length != 0){
                        textoLabel2 = lugare.name as String
                    } else {
                    textoLabel2 = ""
                    }
                }
                
            textoLabel3 = "\(self.fechaHoraStr(eventoAnidao.startDate)) - \(self.fechaHoraStr(eventoAnidao.endDate))"
  
                if(eventoAnidao.actors.count != 0){
                    let strMutu = NSMutableString()
                    strMutu.appendString(personasEvento(eventoAnidao.actors) as String)
                    textoLabel4 = strMutu as String
                }
                
            formatoLabel1 = cell.fontTextoNegrita
            formatoLabel2 = cell.fontTextoMediano
            formatoLabel3 = cell.fontTextoMediano
            formatoLabel4 = cell.fontTextoMediano
            
            if (eventoAnidao.type == "Break"){
                heightImagen = 70
                
                }}
    
            sumaAlHeight = 15
            widthCell = view.frame.width - 80

        }
    
        var height:CGFloat!
        var heightTexto : CGFloat!

        
        let label1 = UILabel()
        
        if (hayImagen == true) {
            
            label1.frame = CGRectMake(0, 0, widthCell - 90, CGFloat.max)
            
        } else {
            label1.frame = CGRectMake(0, 0, widthCell, CGFloat.max)
        }
        
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.textAlignment = cell.modoJustificado
        label1.font = formatoLabel1
        label1.text = textoLabel1 as? String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.textAlignment = cell.modoJustificado
        label2.font = formatoLabel2
        label2.text = textoLabel2  as? String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.textAlignment = cell.modoJustificado
        label3.font = formatoLabel3
        label3.text = textoLabel3  as String
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label1.textAlignment = cell.modoJustificado
        label4.font = formatoLabel4
        label4.text = textoLabel4  as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, widthCell, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.textAlignment = cell.modoJustificado
        label5.font = formatoLabel5
        label5.text = textoLabel5  as String
        
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
    
        var descripcionString:NSString!
        let arraCellLabels = [cell.label1,cell.label2,cell.label3,cell.label4]
        
        if (tieneEventoSup == true) {
        
            if (tableView == detailEventView.tablaConfHeader) {
                var lugarString:NSString!
                var descripcionString:NSString!
            
                cell.backgroundColor = UIColor (rgba: eventoSup.palette.color1 as String)
                
                cell.label1.text = self.eventoSup.realTitulo() as String
                cell.label2.text = "\(self.fechaHoraStr(eventoSup.startDate)) - \(self.fechaHoraStr(eventoSup.endDate))"
                cell.label3.text = self.fechaDia(eventoSup.startDate) as String
                
                let lugare = eventoSup.place
                if(lugare.isDataAvailable()){
                    lugare.fetchFromLocalDatastoreInBackground()
                    
                    if (lugare.name.length != 0){
                        cell.label4.text  = lugare.name as String
                    }
                }
                
            for celdi in arraCellLabels{
            celdi.textColor = UIColor (rgba: eventoSup.palette.color2 as String)
               }
                
                cell.label1.font = cell.fontTextoNegrita
                cell.label2.font = cell.fontTextoMediano
                cell.label3.font = cell.fontTextoMediano
                cell.label4.font = cell.fontTextoMediano
                
                if !(self.eventoSup.icon.parseFileV1.getData() == nil) {
                    cell.imagen.image = UIImage(data: self.eventoSup.icon.parseFileV1.getData()!, scale:3.0)
                    cell.imagenWidth.constant = 70
                    cell.imagenHeight.constant = 70
                    cell.imagenTop.constant = 0
                    cell.imagenBot.constant = 0
                } else {
                    cell.imagenWidth.constant = 0
                }
                eventoSup.fetchFromLocalDatastoreInBackground()
                
                if (eventoSup.place.name == evento.place.name) {
                    cell.label4.text = ""
                }
                
                if (self.fechaDia(eventoSup.startDate) == self.fechaDia(evento.startDate)) {
                    cell.label3.text = ""
                }
            
                return cell
            }}

        if (tableView == detailEventView.tablaHeader) {
            
            let colorete = evento.palette as ColorPalette
            colorete.fetchFromLocalDatastoreInBackground()
            
            cell.backgroundColor = UIColor (rgba: colorete.color1 as String)
        
            cell.label1.text = self.evento.realTitulo() as String
            cell.label2.text = "\(self.fechaHoraStr(evento.startDate)) - \(self.fechaHoraStr(evento.endDate))"
            cell.label3.text = self.fechaDia(evento.startDate) as String
            
            let lugare = evento.place
            if(lugare.isDataAvailable()){
                lugare.fetchFromLocalDatastoreInBackground()
                
                if (lugare.name.length != 0){
                    cell.label4.text  = lugare.name as String
                }
            }
            
            for celdi in arraCellLabels{
                celdi.textColor = UIColor (rgba: evento.palette.color2 as String)
            }
            
            cell.label1.font = cell.fontTextoNegrita
            cell.label2.font = cell.fontTextoMediano
            cell.label3.font = cell.fontTextoMediano
            cell.label4.font = cell.fontTextoMediano
            
            cell.fav.image = UIImage(named: "celda_favorito.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.fav.tintColor = UIColor (rgba: evento.palette.color2 as String)
            cell.fav.hidden = true
            
            let user = PFUser.currentUser()!
            let quer = Rating.query()
            quer!.fromLocalDatastore()
            quer!.whereKey("user", equalTo:user)
            quer!.whereKey("type", equalTo:"fav")
            quer!.whereKey("event", equalTo: evento)
            
            quer!.findObjectsInBackground().continueWithBlock({
                (task: BFTask!) -> AnyObject! in
                if task.error != nil {
                    println(task.error)
                    
                    return task
                }
                else
                {
                    if(task.result.count == 0){
                        cell.fav.hidden = true
                        cell.favWidth.constant = 0
                    }
                    else{
                        cell.fav.hidden = false
                        cell.favWidth.constant = 20
                    }}
                self.defolto.synchronize()
                return task
            })

            if (tieneEventoSup == true) {
                cell.backgroundColor = UIColor (rgba: evento.palette.color1 as String)
            }
            
            if !(self.evento.headerImage.isDataAvailable()) {
            
            if (self.evento.icon.isDataAvailable()) {
                evento.icon.fetchFromLocalDatastoreInBackground()
                evento.icon.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                
            if(error != nil){
                cell.imagenWidth.constant = 0
                    }
                    else{
                cell.imagen.image = UIImage(data:datata!, scale:3.0)
                cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                cell.viewContent.backgroundColor = UIColor .whiteColor()
                cell.viewInfo.backgroundColor = UIColor (rgba: self.evento.palette.color1 as String)
                cell.imagenWidth.constant = 90
                cell.imagenHeight.constant = 90
                cell.imagenTop.constant = 0
                cell.imagenBot.constant = 0
                    }
                })
                
            }
            else {
                cell.imagenWidth.constant = 0
                }
                
            } else {
                
                cell.imagenWidth.constant = 0
            }
            
            if (evento.type == "Break") {
                cell.viewContent.backgroundColor = UIColor .clearColor()
                
            }
            return cell
        }
            
        if (tableView == detailEventView.tabla1) {
            
            let mobiFi = self.evento.headerImage
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
                        cell.imageFull.contentMode = UIViewContentMode.ScaleAspectFit
                        cell.imageFull.hidden = false
                        
                    }})
                
                
            } else {
                cell.imageFull.hidden = true
            }
            
        }
        
        else if (tableView == detailEventView.tablaSpeaker){
        
            cell.viewContentBot.constant = 2
            cell.label1Top.constant = 7
            cell.label5Bot.constant = 7
            cell.imagenTop.constant = 0
            cell.imagenBot.constant = 0
            cell.imagenLeft.constant = 3
            
            cell.viewContent.backgroundColor = UIColor .whiteColor()
        
            if (evento.actors.count != 0){
                let o = self.sacaNullActor(evento.actors)
                if (o.objectAtIndex(indexPath.row).isDataAvailable()) {

                    let actorete = o.objectAtIndex(indexPath.row) as! Actor
                    actorete.fetchFromLocalDatastoreInBackground()
                    actorete.person.fetchFromLocalDatastoreInBackground()
            
                    if(actorete.person.isDataAvailable()){
                        
                        if actorete.person.salutation == "" {
                            
                            cell.label1.text = "\(actorete.person.firstName) \(actorete.person.lastName)"
                            
                            
                        } else {
                            
                            
                            cell.label1.text = "\(actorete.person.salutation) \(actorete.person.firstName) \(actorete.person.lastName)"
                            
                            
                        }
                        
        
                        cell.label1.textColor = UIColor .darkGrayColor()
                        cell.label1.font = cell.fontTextoMediano
                        
                        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                        if(idioma == "es")
                        {
                            cell.label2.text = actorete.charge as String
                            
                        }
                        else if(idioma == "en"){
                            
                            cell.label2.text = actorete.chargeLg2 as String
                        }
                            
                        else if(idioma == "pt"){
                            
                            cell.label2.text = actorete.chargeLg3 as String
                        }
                            
                        else{
                            cell.label2.text = actorete.charge as String
                            
                        }
                        
                        cell.label2.textColor = UIColor .darkGrayColor()
                        cell.label2.font = cell.fontTextoPequeño
                    }
            
                    if (actorete.person.profileImage.isDataAvailable()) {
                        
                        let ima = actorete.person.profileImage.parseFileV1 as PFFile
                        ima.getDataInBackgroundWithBlock({ (dataImagen, error) -> Void in
                            
                            if(error != nil){
                                println(error)}
                                
                            else{
                                
                                let image = UIImage(data:dataImagen!,scale:3.0)
                                cell.imagen.image = image
                            }})

                    } else {
                        cell.imagen.image = UIImage (named: "speaker_nofoto")
                    }
                    cell.imagen.layer.cornerRadius = 33/2
                    cell.imagen.clipsToBounds = true
                    cell.imagenHeight.constant = 33
                    cell.imagenWidth.constant = 33
                }
            }
            
            return cell
        }
    
        if (tableView == detailEventView.tablaDescripcion) {
            
            cell.viewContentLeft.constant = 10
            cell.viewContentTop.constant = 5
            cell.viewContentRight.constant = 10
            cell.viewContentBot.constant = 5
            
            if (evento.details.length != 0){
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    cell.label1.text = evento.details as String
                    
                }
                else if(idioma == "en"){
                    
                    cell.label1.text = evento.detailsLg2 as String
                }
                    
                    
                else if(idioma == "pt"){
                    
                    cell.label1.text = evento.detailsLg3 as String
                }
                    
                else{
                    cell.label1.text = evento.details as String
                    
                }
                
                cell.label1.font = cell.fontTextoMediano
                cell.imagenWidth.constant = 0
            }
            
            return cell
        }
    
        else if (tableView == detailEventView.tablaEvento) {
            
             if (self.anidaosFiltraos.count != 0) {
           
            var eventoAnidao = self.anidaosFiltraos.objectAtIndex(indexPath.row) as! Event

                if(eventoAnidao.isDataAvailable()){
                    eventoAnidao.fetchFromLocalDatastoreInBackground()
                    let colore = eventoAnidao.palette as ColorPalette
                    colore.fetchFromLocalDatastoreInBackground()
                    cell.backgroundColor = UIColor (rgba: colore.color1 as String)

                    cell.viewContent.backgroundColor = UIColor .whiteColor()
                    cell.separator.backgroundColor = UIColor .whiteColor()
            
                    cell.viewContentLeft.constant = 14
                    cell.viewContentBot.constant = 4
                
                    cell.fav.image = UIImage(named: "celda_favorito.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                    cell.fav.tintColor = UIColor (rgba: meetingApp.palette.color3 as String)
                    cell.fav.hidden = true
                
                    let user = PFUser.currentUser()!
                    let quer = Rating.query()
                    quer!.fromLocalDatastore()
                    quer!.whereKey("user", equalTo:user)
                    quer!.whereKey("type", equalTo:"fav")
                    quer!.whereKey("event", equalTo: eventoAnidao)
                    
                    quer!.findObjectsInBackground().continueWithBlock({
                        (task: BFTask!) -> AnyObject! in
                        if task.error != nil {
                            println(task.error)
                            
                            return task
                        }
                        else
                        {
                            if(task.result.count == 0){
                                cell.fav.hidden = true
                                cell.favWidth.constant = 0
                            }
                            else{
                                cell.fav.hidden = false
                                cell.favWidth.constant = 20
                            }}
                        self.defolto.synchronize()
                        return task
                    })
            
                    cell.label1.text = eventoAnidao.realTitulo() as String
                    cell.label1.textColor = UIColor .darkGrayColor()
                    cell.label1.font = cell.fontTextoNegrita
                }
                
                let lugare = eventoAnidao.place
                
                if(lugare.isDataAvailable()){
                    lugare.fetchFromLocalDatastoreInBackground()
                    if (lugare.name.length != 0){
                        cell.label2.text = lugare.name as String
                        cell.label2.textColor = UIColor .darkGrayColor()
                        cell.label2.font = cell.fontTextoMediano
                    }
                } else {
                    cell.label2.text = ""
                }
    
                cell.label3.text = "\(self.fechaHoraStr(eventoAnidao.startDate)) - \(self.fechaHoraStr(eventoAnidao.endDate))"
                cell.label3.textColor = UIColor .darkGrayColor()
                cell.label3.font = cell.fontTextoMediano
           
                if(eventoAnidao.actors.count != 0){
                    let strMutu = NSMutableString()
                    strMutu.appendString(personasEvento(eventoAnidao.actors) as String)
                    cell.label4.text = strMutu as String
                    cell.label4.textColor = UIColor .darkGrayColor()
                    cell.label4.font = cell.fontTextoMediano
                } else {
                    cell.label4.text = ""
                }
            
            if (eventoAnidao.icon.isDataAvailable()) {
                
                eventoAnidao.icon.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                    
                    if (error != nil){
                        cell.imagenWidth.constant = 0

                    }
                    else{
                        cell.imagen.image = UIImage(data: eventoAnidao.icon.parseFileV1.getData()!)
                        cell.imagenWidth.constant = 70
                        cell.imagenHeight.constant = 70
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit

                    }
                })
            }
            else {
                cell.imagenWidth.constant = 0

            }
            
            if (eventoAnidao.type == "Break") {
            
                cell.viewContent.backgroundColor = UIColor .clearColor()
                cell.viewInfo.backgroundColor = UIColor .whiteColor()
               
                if (eventoAnidao.icon.isDataAvailable()) {
                    eventoAnidao.icon.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                        
                        if(error != nil){
                            cell.imagen.image = UIImage (named: "cafe")
                        }
                        else{
                        cell.imagen.image = UIImage(data:datata!, scale: 3.0)
                        }
                    })
                }
                else {
                    cell.imagen.image = UIImage (named: "cafe")
                }
                
                cell.viewContentLeft.constant = 0
                cell.imagenWidth.constant = 72
                cell.imagenHeight.constant = 54

            }}
            
    
        }
        
        cell.needsUpdateConstraints()
        cell.layoutIfNeeded()
        
        return cell

    }
    //métodos pa las celdas

    func sacaNullActor(actores:NSArray) -> NSArray{
    
        var arraActores = NSArray()
        if(actores.count != 0){
            var o = NSMutableArray(array: actores)
            for cadaHuea in o {
                if(cadaHuea.isKindOfClass(NSNull)){
                    o.removeObject(cadaHuea)
                }}
            arraActores = o
        }
        return arraActores

    }
    func personasEvento(eventActores:NSArray) -> NSString{

        let strMutu = NSMutableString()
        let o = self.sacaNullActor(eventActores)
        var personaUno = o.firstObject as! Actor
        personaUno.fetchFromLocalDatastoreInBackground()
        
        if personaUno.isDataAvailable() {
        
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
            }
        }
        }
        return strMutu
    }

    func fechaHoraStr(horaFecha:NSDate) -> NSString{
        
        let hora = MCDateFormatter().HorayMinutos().stringFromDate(horaFecha)
        return hora
    }
    
    func fechaDia(diaFecha:NSDate) -> NSString{
        
        let dia = MCDateFormatter().DiayMes().stringFromDate(diaFecha)
        return dia
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (tableView == detailEventView.tablaEvento) {
            
            let eventoAnidado = self.anidaosFiltraos.objectAtIndex(indexPath.row) as! Event
            let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("detalleViewController") as! detalleViewController
            detalle.evento = eventoAnidado
            detalle.eventoSup = evento
            detalle.tieneEventoSup = true
            detalle.meetingApp = meetingApp
            self.navigationController?.pushViewController(detalle, animated: true)
        }
        else if (tableView == detailEventView.tablaSpeaker) {
        

            let evento = self.anidaosFiltraos.objectAtIndex(indexPath.row) as! Event
          
            let actors = evento.actors.objectAtIndex(indexPath.row) as! Actor
            let detallePersona = self.storyboard?.instantiateViewControllerWithIdentifier("expositoresDetalleViewController") as! expositoresDetalleViewController
            
            detallePersona.persona = actors.person
            self.navigationController?.pushViewController(detallePersona, animated: true)

        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    func aparecerAvisoFavorito() {
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("removerAvisoFavorito"), userInfo: nil, repeats: false)
        
        var texto = NSString()
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
//
//            texto = " Agregado a Favoritos"
            texto = " Added to Favorites"
            
        }
        else if(idioma == "en"){
            
            texto = " Added to Favorites"

        }
            
        else if(idioma == "pt"){
            
                        texto = " Agregado a Favoritos"

        }
            
        else{
            
                        texto = " Agregado a Favoritos"

            
        }
        
        var label1:UILabel!
        
        if device == .iPhone6Plus {
            
            label1 = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 25))
            label1.textAlignment = NSTextAlignment.Center
            label1.font = UIFont(name: "ArialMT", size: 15)
            label1.text = texto as String
            label1.sizeToFit()
            
        }
        
        if device == .iPhone6 {
            
            label1 = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 25))
            label1.textAlignment = NSTextAlignment.Center
            label1.font = UIFont(name: "ArialMT", size: 15)
            label1.text = texto as String
            label1.sizeToFit()
            
        }
        
        if device == .iPhone5s || device == .iPhone5c || device == .iPhone5 {
            
            label1 = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 50))
            label1.numberOfLines = 0
            label1.textAlignment = NSTextAlignment.Center
            label1.font = UIFont(name: "ArialMT", size: 15)
            label1.text = texto as String
            label1.sizeToFit()
            
        }
        
        if device == .iPhone4s {
            
            label1 = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 50))
            label1.numberOfLines = 0
            label1.textAlignment = NSTextAlignment.Center
            label1.font = UIFont(name: "ArialMT", size: 15)
            label1.text = texto as String
            label1.sizeToFit()
        
        }
        
        if device == .Simulator {
            
            label1 = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 25))
            label1.numberOfLines = 0
            label1.textAlignment = NSTextAlignment.Center
            label1.font = UIFont(name: "ArialMT", size: 15)
            label1.text = texto as String
            label1.sizeToFit()
            
        }
        
        acFavorito = UILabel (frame: CGRectMake(((view.frame.width * 0.5) - (label1.frame.width + 20) / 2), detailEventView.frame.height - 80 , label1.frame.width + 20, 25))
        
        acFavorito.text = texto as String
        acFavorito.textColor = UIColor .whiteColor()
        acFavorito.textAlignment = NSTextAlignment.Center
        acFavorito.font = UIFont(name: "ArialMT", size: 15)
        acFavorito.backgroundColor = UIColor .darkGrayColor().colorWithAlphaComponent(0.8)
        acFavorito.layer.cornerRadius = 9
        acFavorito.layer.masksToBounds = true
        acFavorito.alpha = 0
        
        detailEventView.addSubview(acFavorito)
        acFavorito.fadeIn()
    }
    override func viewDidAppear(animated: Bool) {
          }
    
    func removerAvisoFavorito() {
        acFavorito.fadeOut()
        }
}



