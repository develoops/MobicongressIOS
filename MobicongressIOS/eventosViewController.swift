//
//  eventosViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 19-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class eventosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    var eem = Bool()
    var tabla = UITableView()
    var eventos : MeetingApp!
    var flechaI = UIButton()
    var flechaD = UIButton()
    var arraya = NSArray()
    var arra = NSArray()
    var mutu = NSMutableArray()
    var dia:NSString!
    var diaIndicaor = Int()
    var labelDia:UILabel!
    var DiaBarra:NSString!
    var fondoBarraDias:UIImageView!
    var toolbar = UIToolbar()
    var predicao = NSPredicate()
    var defolto = NSUserDefaults()
    var titleView1 : String!
    var titleView2 : String!
    
    var searchController: UISearchController!
    var searchArray:NSArray!
    
    override func viewWillAppear(animated: Bool) {
        self.tabla .reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emmValor()
        self.filtre()
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        self.tabla.dataSource = self
        self.tabla.delegate = self
        self.tabla.frame = CGRectMake(0, 44, view.frame.size.width, view.frame.size.height - 154)
        self.view.addSubview(self.tabla)
        
        self.agregarBotonVolver()
        tabla.rowHeight = UITableViewAutomaticDimension
        tabla.backgroundColor = UIColor (rgba: eventos.palette.color2 as String)
        tabla.separatorColor = UIColor .clearColor()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "retrocedeDia")
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        toolbar.addGestureRecognizer(rightSwipe)
        tabla.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "avanzaDia")
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        toolbar.addGestureRecognizer(leftSwipe)
        tabla.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(leftSwipe)
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {

        
            // Configure countrySearchController
        self.searchController = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.translucent = false
            controller.searchBar.backgroundColor = UIColor (rgba: self.eventos.palette.color4 as String)
            controller.searchBar.barTintColor = UIColor .whiteColor()
            controller.searchBar.tintColor = UIColor .whiteColor()
            controller.searchBar.barStyle = .Black
            self.tabla.tableHeaderView = controller.searchBar
            
                       return controller
        })()
            
        }
    
    }
    
    func emmValor(){
        let fecha = NSDate(timeIntervalSinceNow:-(60*60*3))
        let valor = eventos.startDate.compare(fecha).rawValue - eventos.endDate.compare(fecha).rawValue
        
        println(eventos.startDate.compare(fecha).rawValue)
        println(eventos.endDate.compare(fecha).rawValue)
        
        if (valor != 0){
            
            eem = true
            
        }
        else{
            eem = false
            
        }
    }

    func cambioDias(){

        toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44)
        var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    
        var fixedSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixedSpace.width = 40.0
    
        let imagenIzquierda = UIImage(named: "left")
        let imagenDerecha = UIImage(named: "right")
    
        var botonAtras = UIBarButtonItem(image: imagenIzquierda, style: UIBarButtonItemStyle.Plain , target: self, action: "retrocedeDia")
        var labelBotonDia = UIBarButtonItem(customView: labelDia)
        var botonAdelante = UIBarButtonItem(image: imagenDerecha, style:UIBarButtonItemStyle.Plain, target: self, action: "avanzaDia")
    
        var toolbarButtons = [fixedSpace, botonAtras,flexibleSpace,labelBotonDia,flexibleSpace,botonAdelante, fixedSpace];
        
        toolbar.translucent = false
        toolbar.barTintColor = UIColor (rgba: eventos.palette.color4 as String)
        toolbar.setItems(toolbarButtons, animated: true)
        toolbar.tintColor = UIColor .whiteColor()
        view .addSubview(toolbar)
    }
    
    func filtre(){
        if (self.eventos.events.count != 0){
        let arrayaPaFechas = self.eventos.events.valueForKey("startDate") as! NSArray
            
        var formato = NSDateFormatter()
        formato.dateFormat = "yyyy-MM-dd"
        
        var sorto = NSComparisonResult.OrderedAscending
        for fechaInicio in arrayaPaFechas{
            
            let s = formato.stringFromDate(fechaInicio as! NSDate)
            self.mutu.addObject(s)
        }
            
            let anidaos = NSMutableArray()
            for oje in self.eventos.events{
                if let eve = oje as? Event
                {
                    for anidao in eve.anidateEvents{
                        
                        if let ani = anidao as? Event{
                            
                            anidaos.addObject(ani.objectId!)
                            
                        }
                        
                    }
                }
            }


        self.mutu.setArray(NSSet(array: self.mutu as [AnyObject]).allObjects)
            
        var descriptor: NSSortDescriptor = NSSortDescriptor(key: "self", ascending: true)
        self.arra = self.mutu.sortedArrayUsingDescriptors([descriptor]) as NSArray
        
        let fecha = self.arra.objectAtIndex(diaIndicaor) as! NSString
        let s = formato.dateFromString(fecha as String)

        var formatoDias = NSDateFormatter()
        formatoDias.dateFormat = "EEE dd"
        
        let fechaAhora = NSDate(timeIntervalSinceNow:-60*60*3)
            
        labelDia = UILabel(frame: CGRectMake(0, 0, 100, 44))
        labelDia.textAlignment = .Center
        labelDia.text = formatoDias.stringFromDate(s!)
        labelDia.textColor = UIColor .whiteColor()
        
        var calendario = NSCalendar.currentCalendar()
        let componente = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: s!)
        componente.hour = -5
        let componente2 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: s!)
        componente2.hour = -5
        let componente3 = calendario.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit , fromDate: fechaAhora)

        componente2.day = componente2.day+1

            //arreglar la huea
        let predica = NSPredicate(format:"(startDate > %@) AND(endDate < %@) AND !(objectId IN %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!,anidaos)

           
        predicao = NSPredicate(format:"(startDate > %@) AND(endDate < %@)", calendario.dateFromComponents(componente)!,calendario.dateFromComponents(componente2)!)

        var predicaoEmm = NSPredicate(format:"(startDate <= %@) AND (endDate >= %@) AND (anidateEvents == nil)", calendario.dateFromComponents(componente3)!,calendario.dateFromComponents(componente3)!)
            
        var descriptorFechaInicio: NSSortDescriptor = NSSortDescriptor(key:"startDate", ascending: true)
        var descriptorFechaFin: NSSortDescriptor = NSSortDescriptor(key:"endDate", ascending: true)

        let arraOrdenao = self.eventos.events.sortedArrayUsingDescriptors([descriptorFechaInicio,descriptorFechaFin]) as NSArray

        if(eem == false)
        {
            self.arraya = arraOrdenao.filteredArrayUsingPredicate(predica)
            self.cambioDias()
            self.title = titleView1
            self.tabla.frame = CGRectMake(0, 44, view.frame.size.width, view.frame.size.height - 44)
        }
    else
        {
            self.arraya = arraOrdenao.filteredArrayUsingPredicate(predicaoEmm)
            self.title = titleView2
            self.toolbar.removeFromSuperview()
            self.labelDia.removeFromSuperview()
            self.flechaI.removeFromSuperview()
            self.flechaD.removeFromSuperview()
            self.tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
}
            self.tabla.reloadData()

        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.agregarBotonVolver()
    }
    
    func avanzaDia(){
        if (self.diaIndicaor < self.arra.count-1)
        {
            self.diaIndicaor = self.diaIndicaor+1
        }
        self.filtre()
    }
    
    func retrocedeDia(){
        if (self.diaIndicaor != 0)
        {
            self.diaIndicaor = self.diaIndicaor-1
        }
        self.filtre()
    }
    func agregarBotonVolver(){

        var bMeetings = UIBarButtonItem(image: UIImage(named: "directorio"), style: .Plain, target: self, action: "listaMeetings:")
        let newTitle = "News" + String(eventos.walls.count)
        var bNews = UIBarButtonItem(image: UIImage(named: "novedades"), style: .Plain, target: self, action: "muestraNews:")
       
        if(eventos.walls.count != 0){
            
            navigationItem.leftBarButtonItems = [bMeetings,bNews]
        }
        else{
            navigationItem.leftBarButtonItems = [bMeetings]
        }
        
        if(self.eem == false){
        var bEmm = UIBarButtonItem(image: UIImage(named: "eem"), style: .Plain, target: self, action: "muestraEem:")
            self.navigationItem.rightBarButtonItems = [bEmm]
        }
        else{
        var bPrograma = UIBarButtonItem(image: UIImage(named: "program"), style: .Plain, target: self, action: "muestraPrograma:")
        self.navigationItem.rightBarButtonItems = [bPrograma]
    }
}
    func listaMeetings(sender: UIBarButtonItem) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func muestraEem(sender: UIBarButtonItem) {
        self.eem = true
        self.filtre()
        var bPrograma = UIBarButtonItem(image: UIImage(named: "program"), style: .Plain, target: self, action: "muestraPrograma:")
        
        self.navigationItem.rightBarButtonItems = [bPrograma]
    }
    
    func muestraPrograma(sender: UIBarButtonItem) {
        
        self.eem = false
        self.filtre()
        var bEmm = UIBarButtonItem(image: UIImage(named: "eem"), style: .Plain, target: self, action: "muestraEem:")
        self.navigationItem.rightBarButtonItems = [bEmm]
    }
    
    func muestraNews(sender: UIBarButtonItem) {
        let newsView = self.storyboard?.instantiateViewControllerWithIdentifier("newsViewController") as! newsViewController
        let mutuNew = NSMutableArray()
        for wall in eventos.walls{
            if let noti = wall as? Wall{

                if(noti.isDataAvailable()){
        noti.fetchFromLocalDatastoreInBackground()
            for _new in noti.news{
            if let nove = _new as? New{
            mutuNew.addObject(nove)
            
                }}}}}
        newsView.newsArra = mutuNew
        self.navigationController?.pushViewController(newsView, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
        
            if (self.searchController.active) {
                return self.searchArray.count ?? 0
            } else {
                return self.arraya.count ?? 0
            }
            
        } else {
            
            return self.arraya.count ?? 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat!
    
        var evento = Event()
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            
            if (self.searchController.active) {
                evento = self.searchArray.objectAtIndex(indexPath.row) as! Event
            } else {
                evento = self.arraya.objectAtIndex(indexPath.row) as! Event
            }
            
        } else {
            evento = self.arraya.objectAtIndex(indexPath.row) as! Event
        }
    
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        var lugarString = NSString()
        var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(evento.startDate)
        var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(evento.endDate)
        
        let strMutu = NSMutableString()
        
        if(evento.actors.count != 0){
            
        strMutu.appendString(self.personasEvento(evento.actors) as String)
        }
        
        let lugare = evento.place as Place
        if(lugare.isDataAvailable()){
            lugare.fetchFromLocalDatastoreInBackground()
        if (lugare.name.length != 0){
            lugarString = lugare.name as NSString
        } else {
            lugarString = ""
        }
    }
        
        var textoLabel1 = evento.realTitulo()
        var textoLabel2 = lugarString
        var textoLabel3 = "\(horaInicioString) - \(horaFinString)"
        var textoLabel4 = strMutu
        
        let label1 = UILabel()
        
        if (evento.icon.isDataAvailable()) {
        
            label1.frame = CGRectMake(0, 0, view.frame.width - 90, CGFloat.max)
            
        } else {
            label1.frame = CGRectMake(0, 0, view.frame.width, CGFloat.max)
        }
        
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.textAlignment = cell.modoJustificado
        label1.font = cell.fontTextoNegrita
        label1.text = textoLabel1 as? String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, view.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.textAlignment = cell.modoJustificado
        label2.font = cell.fontTextoMediano
        label2.text = textoLabel2 as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, view.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.textAlignment = cell.modoJustificado
        label3.font = cell.fontTextoMediano
        label3.text = textoLabel3
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, view.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label1.textAlignment = cell.modoJustificado
        label4.font = cell.fontTextoMediano
        label4.text = textoLabel4 as String
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, view.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.textAlignment = cell.modoJustificado
        label5.font = cell.fontTextoMediano
        label5.text = ""
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        label4.sizeToFit()
        label5.sizeToFit()
        
        if (evento.type == "Break"){
            heightImagen = 70
        }
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 15
        
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
        var evento = Event()
        var tipoEvento = evento.type as NSString
        
        var textoLabel1 = NSString()
        var textoLabel2 = NSString()
        var textoLabel3 = NSString()
        var textoLabel4 = NSString()
        var textoLabel5 = NSString()
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
        
            if (self.searchController.active) {
                evento = self.searchArray.objectAtIndex(indexPath.row) as! Event
            } else {
                evento = self.arraya.objectAtIndex(indexPath.row) as! Event
            }
        } else {
         
            evento = self.arraya.objectAtIndex(indexPath.row) as! Event
            
        }
        
        cell.fav.image = UIImage(named: "celda_favorito.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.fav.tintColor = UIColor (rgba: eventos.palette.color3 as String)
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
        
        var lugarString = NSString()
        var horaInicioString = MCDateFormatter().HorayMinutos().stringFromDate(evento.startDate)
        var horaFinString = MCDateFormatter().HorayMinutos().stringFromDate(evento.endDate)
        
        let strMutu = NSMutableString()
        evento.fetchFromLocalDatastoreInBackground()
        
        if(evento.actors.count != 0){
            strMutu.appendString(personasEvento(evento.actors) as String)
        
            }

        if(evento.palette.isDataAvailable()){
            cell.backgroundColor = UIColor (rgba: evento.palette.color1 as String)

        }
        else{
            cell.backgroundColor = UIColor (rgba: "#000000")
        }
    
        cell.viewContentLeft.constant = 14
        cell.viewContentBot.constant = 4
        cell.viewInfo.backgroundColor = UIColor .whiteColor()
        cell.separator.backgroundColor = UIColor .whiteColor()
        cell.separator.hidden = false
        let lugare = evento.place
        if(lugare.isDataAvailable()){
        lugare.fetchFromLocalDatastoreInBackground()
        
        if (lugare.name.length != 0){
            lugarString = lugare.name as NSString
        }
       else {
            lugarString = ""
        }
    }
        
        cell.label1.text = evento.realTitulo() as String
        cell.label2.text = lugarString as String
        cell.label3.text = "\(horaInicioString) - \(horaFinString)"
        cell.label4.text = strMutu  as String
        
        cell.label1.textColor = UIColor .darkGrayColor()
        cell.label1.font = cell.fontTextoNegrita
        cell.label1.lineBreakMode = cell.modoTerminoDeLinea
        cell.label1.textAlignment = cell.modoJustificado
        cell.label1.font = cell.fontTextoNegrita
        cell.label2.textColor = UIColor .darkGrayColor()
        cell.label2.font = cell.fontTextoMediano
        cell.label3.textColor = UIColor .darkGrayColor()
        cell.label3.font = cell.fontTextoMediano
        cell.label4.textColor = UIColor .darkGrayColor()
        cell.label4.font = cell.fontTextoMediano
        
        let iconoEvento = evento.icon as MobiFile
        iconoEvento.fetchFromLocalDatastoreInBackground()

        if (iconoEvento.isDataAvailable()) {
        
            iconoEvento.parseFileV1.getDataInBackgroundWithBlock({ (datata:NSData?, error:NSError?) -> Void in
                
                if(error != nil){   
                
                    cell.imagenWidth.constant = 0

                }else{
                    cell.imagen.image = UIImage(data:datata!, scale: 3.0)
                    cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                    cell.viewContent.backgroundColor = UIColor .whiteColor()
                    cell.imagenWidth.constant = 70
                    cell.imagenHeight.constant = 70
                }
            })
        }
        else{
            cell.imagenWidth.constant = 0

        }
        
        if (evento.type == "Break") {
            
            if !(evento.icon.parseFileV1.getData() == nil) {
                cell.viewContent.backgroundColor = UIColor .clearColor()
                cell.imagen.image = UIImage(data: evento.icon.parseFileV1.getData()!, scale: 3.0)
                cell.viewContentLeft.constant = 0
                cell.imagenWidth.constant = 72
                cell.imagenHeight.constant = 54
            } else {
                cell.viewContent.backgroundColor = UIColor .clearColor()
                cell.viewContentLeft.constant = 0
                cell.imagen.image = UIImage (named: "cafe")
                cell.imagenWidth.constant = 72
                cell.imagenHeight.constant = 54
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tabla.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(self.searchController.active){
        let evento = self.searchArray.objectAtIndex(indexPath.row) as! Event
        let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("detalleViewController") as! detalleViewController
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
         
            self.searchController.active = false
            
        }
        
        detalle.evento = evento
        detalle.predicaoDia = predicao
        detalle.meetingApp = eventos
        self.navigationController?.pushViewController(detalle, animated: true)
        }
        else{
        
            let evento = self.arraya.objectAtIndex(indexPath.row) as! Event
            let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("detalleViewController") as! detalleViewController
            
            if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
                
                self.searchController.active = false
                
            }
            
            detalle.evento = evento
            detalle.predicaoDia = predicao
            detalle.meetingApp = eventos
            self.navigationController?.pushViewController(detalle, animated: true)
        
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillDisappear(animated: Bool) {
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            searchController.active = false
        }
    }
}


extension eventosViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        
        let searchPredicate = NSPredicate(format: "(title contains[cd] %@) OR (titleLg2 contains[cd] %@)", searchController.searchBar.text,searchController.searchBar.text)
        let array = self.arraya.filteredArrayUsingPredicate(searchPredicate)
        if array.count == 0 {
            
            self.searchArray = array
            self.tabla.reloadData()
            
        } else {
            
            self.searchArray = array
            self.tabla.reloadData()
            
        }
    }
    
    func willDismissSearchController(searchController: UISearchController) {
        self.searchController.active = false
        self.searchArray = arraya
        self.tabla.reloadData()
    }
    
    
}
