//
//  favoritosViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 09-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class favoritosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var meetingFav :MeetingApp!
    var favoritos = NSArray()
    var tabla = UITableView()
    var titleView : String!
    var dias = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.frame = self.view.frame
        self.tabla.separatorColor = UIColor .clearColor()
        self.tabla.backgroundColor = UIColor .clearColor()

        var labelNoFav:UILabel = UILabel(frame: CGRectMake(10, 30, self.view.frame.width - 20, 60))
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
//            labelNoFav.text = "No tienes eventos favoritos"
            labelNoFav.text = "You don't have favorite events"
            
        }
        else if(idioma == "en"){
            
            labelNoFav.text = "You don't have favorite events"
        }
            
        else if(idioma == "pt"){
            
            labelNoFav.text = "Você não tem eventos favoritos"
        }
            
        else{
            labelNoFav.text = "No ha asignado favoritos"
            
        }
        
        labelNoFav.numberOfLines = 0
        labelNoFav.textColor = UIColor (rgba: meetingFav.palette.color4 as String)
        labelNoFav.textAlignment = NSTextAlignment.Center
        labelNoFav.font = UIFont(name: "ArialMT", size: 15)
        
        view.backgroundColor = UIColor (rgba: meetingFav.palette.color2 as String)

        self.view.addSubview(labelNoFav)
        self.view.addSubview(self.tabla)
        self.llama()

    }
    
    override func viewDidAppear(animated: Bool) {
        
            self.llama()
            self.title = titleView
            self.tabla.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
    
        self.llama()
    }
    
    func llama() {
    
        var fav = Rating.query()
        fav?.fromLocalDatastore()
        fav?.whereKey("type", equalTo: "fav")
        fav?.whereKey("user", equalTo:PFUser.currentUser()!)
        
        fav?.findObjectsInBackground().continueWithBlock({
            (task: BFTask!) -> AnyObject! in
            if task.error != nil {
                println(task.error)
                
                return task
            }
            else
            {
                if(task.result.count == 0){
                }
                else{
                    let mutuDias = NSMutableArray()

                if(task.completed == true){
                    self.favoritos = task.result.valueForKey("event") as! NSArray
                    self.tabla.backgroundColor = UIColor (rgba: self.meetingFav.palette.color2 as String)
                 
                    for object in self.favoritos.valueForKey("startDate") as!  NSArray{
                        
                        let formato = NSDateFormatter()
                        formato.dateFormat = "yyyy-MM-dd"
                        let dia = formato.stringFromDate(object as! NSDate)
                        mutuDias.addObject(dia)
                        
                    }

                    let set = NSSet(array: mutuDias as [AnyObject])
            self.dias = set.allObjects.sorted { $0.localizedCaseInsensitiveCompare($1 as! String) == NSComparisonResult.OrderedAscending }
                }
            }
            return task
            
            }})
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return self.dias.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        let f = NSDateFormatter()
        let formatoDias = NSDateFormatter()
        formatoDias.dateFormat = "EEE dd"
        f.dateFormat = "yyyy-MM-dd"
        let dia = self.dias.objectAtIndex(section) as! String
        let date = f.dateFromString(dia)
        
        return formatoDias.stringFromDate(date!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        let dia = self.dias.objectAtIndex(section) as! String
        let date = f.dateFromString(dia)
        
        var calendario = NSCalendar.currentCalendar()

        let componente = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        let componente2 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        
        componente2.day = componente2.day+1

       let predicao = NSPredicate(format:"(startDate >= %@)AND(startDate <= %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!)

        let fa = self.favoritos.filteredArrayUsingPredicate(predicao)
        
        return fa.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        let dia = self.dias.objectAtIndex(indexPath.section) as! String
        let date = f.dateFromString(dia)
        
        var calendario = NSCalendar.currentCalendar()
        
        let componente = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        let componente2 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        
        componente2.day = componente2.day+1

        let predicao = NSPredicate(format:"(startDate >= %@)AND(startDate <= %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!)
        
        let fa = self.favoritos.filteredArrayUsingPredicate(predicao) as NSArray

        let evento = fa.objectAtIndex(indexPath.row) as! Event
        var tipoEvento = evento.type as NSString
        
        var lugarString = NSString()
        var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(evento.startDate)
        var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(evento.endDate)
        
        let strMutu = NSMutableString()
        evento.fetchFromLocalDatastoreInBackground()
        if(evento.actors.count != 0){
            
            var o = NSMutableArray(array: evento.actors)
            
            for cadaHuea in o {

                if(cadaHuea.isKindOfClass(NSNull)){
                    
                    o.removeObject(cadaHuea)
                }}
            
            var personaUno = o.firstObject as! Actor
            let personaLocal = personaUno.person as Person
            personaLocal.fetchFromLocalDatastoreInBackground()
            
            if personaLocal.isDataAvailable() {

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
        
        if(evento.palette.isDataAvailable()){
            cell.backgroundColor = UIColor (rgba: evento.palette.color1 as String)
            
        }
        else{
            cell.backgroundColor = UIColor (rgba: "#cc9a75")
            
        }
        
        cell.viewContentLeft.constant = 14
        cell.viewContentBot.constant = 4
        cell.viewInfo.backgroundColor = UIColor .whiteColor()
        
        if !(evento.place.name.length == 0){
            lugarString = evento.place.name as NSString
        }
        else if !(evento.place.name.length == 0){
            lugarString = evento.place.name as NSString
        } else {
            lugarString = ""
        }
        
        cell.label1.text = evento.realTitulo() as String
        cell.label2.text = lugarString as String
        cell.label4.text = "\(horaInicioString) - \(horaFinString)"
        cell.label5.text = strMutu as String
        
        cell.label1.textColor = UIColor .darkGrayColor()
        cell.label1.font = cell.fontTextoNegrita
        cell.label2.textColor = UIColor .darkGrayColor()
        cell.label2.font = cell.fontTextoMediano
        cell.label4.textColor = UIColor .darkGrayColor()
        cell.label4.font = cell.fontTextoMediano
        cell.label5.textColor = UIColor .darkGrayColor()
        cell.label5.font = cell.fontTextoMediano
        
        if !(evento.icon.parseFileV1.getData() == nil) {
            cell.imagen.image = UIImage(data: evento.icon.parseFileV1.getData()!, scale: 3.0)
            cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
            cell.viewContent.backgroundColor = UIColor .whiteColor()
            cell.imagenWidth.constant = 70
            cell.imagenHeight.constant = 70
        } else {
            cell.imagenWidth.constant = 0
        }
        
        if (evento.type == "break") {
            
            if !(evento.icon.parseFileV1.getData() == nil) {
                cell.viewContent.backgroundColor = UIColor .clearColor()
                cell.imagen.image = UIImage(data: evento.icon.parseFileV1.getData()!, scale: 3.0)
                cell.viewContentLeft.constant = 0
                cell.imagenWidth.constant = 70
                cell.imagenHeight.constant = 70
            } else {
                cell.viewContent.backgroundColor = UIColor .clearColor()
                cell.viewContentLeft.constant = 0
                cell.imagen.image = UIImage (named: "cafe")
                cell.imagenWidth.constant = 70
                cell.imagenHeight.constant = 70
            }
        }
        
        cell .setNeedsDisplay()
        cell .layoutIfNeeded()
        
        return cell

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        let dia = self.dias.objectAtIndex(indexPath.section) as! String
        let date = f.dateFromString(dia)
        
        var calendario = NSCalendar.currentCalendar()
        
        let componente = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        let componente2 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        
        componente2.day = componente2.day+1
        
        let predicao = NSPredicate(format:"(startDate >= %@)AND(startDate <= %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!)
        
        let fa = self.favoritos.filteredArrayUsingPredicate(predicao) as NSArray

        
        var textoLabel1 = "" as NSString!
        var textoLabel2 = "" as NSString!
        var textoLabel3 = "" as NSString!
        var textoLabel4 = "" as NSString!
        var textoLabel5 = "" as NSString!
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat!
        
        let evento = fa.objectAtIndex(indexPath.row) as! Event
        
        if (evento.icon.isDataAvailable()){
            heightImagen = 70
        } else {
            heightImagen = 0
        }
        
        var lugarString = NSString()
        var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(evento.startDate)
        var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(evento.endDate)
        
        let strMutu = NSMutableString()
        
        if(evento.actors.count != 0){
            var o = NSMutableArray(array: evento.actors)
            
            for cadaHuea in o {
                
                if(cadaHuea.isKindOfClass(NSNull)){
                     
                    o.removeObject(cadaHuea)
                }}
            
            var personaUno = o.firstObject as! Actor
            personaUno.fetchFromLocalDatastoreInBackground()
            let personaLocale = personaUno.person as Person
            
            if personaUno.person.isDataAvailable() {
                personaLocale.fetchFromLocalDatastoreInBackground()
                
                let strUno = "\(personaUno.person.salutation) \(personaUno.person.firstName) \(personaUno.person.lastName)"
                strMutu.appendString(strUno)
            }
            
            for var index = 1; index < o.count; ++index {
                
                let per = o.objectAtIndex(index) as! Actor
                if(per.isDataAvailable()){
                    let personaLocale = per.person as Person
                    personaLocale.fetchFromLocalDatastoreInBackground()
                    
                    if(personaLocale.isDataAvailable()){
                        
                        let strDos = "\n\(per.person.salutation) \(per.person.firstName) \(per.person.lastName)"
                        
                        strMutu.appendString(strDos)
                    }}}}
        
        let lugare = evento.place as Place
        lugare.fetchFromLocalDatastoreInBackground()
        
        if (lugare.name.length != 0){
            lugarString = lugare.name as NSString
        }
        else if !(lugare.name.length == 0){
            lugarString = lugare.name as NSString
        } else {
            lugarString = ""
        }
        
        textoLabel1 = evento.realTitulo() as NSString
        textoLabel2 = lugarString
        textoLabel3 = "\(horaInicioString) - \(horaFinString)"
        textoLabel4 = strMutu
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoNegrita
        label1.text = textoLabel1 as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
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
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 15
        
        if (heightTexto > heightImagen) {
            height = heightTexto
        } else {
            height = heightImagen + 10
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.tabla.deselectRowAtIndexPath(indexPath, animated: true)
        
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        let dia = self.dias.objectAtIndex(indexPath.section) as! String
        let date = f.dateFromString(dia)
        
        var calendario = NSCalendar.currentCalendar()
        
        let componente = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        let componente2 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate:date!)
        
        componente2.day = componente2.day+1
        
        let predicao = NSPredicate(format:"(startDate >= %@)AND(startDate <= %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!)
        
        let fa = self.favoritos.filteredArrayUsingPredicate(predicao) as NSArray

        
        let evento = fa.objectAtIndex(indexPath.row) as! Event
        let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("detalleViewController") as! detalleViewController
        detalle.evento = evento
        detalle.meetingApp = meetingFav
        self.navigationController?.pushViewController(detalle, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
