//
//  expositoresViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 26-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class expositoresViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate{

    var tabla = UITableView()
    var meetingExpositores:MeetingApp!
    var mutuExpo = NSMutableArray()
    var titleView : String!
    var searchController: UISearchController!
    var searchArray = NSArray()
    
    override func viewWillAppear(animated: Bool) {
        self.tabla .reloadData()
        self.searchController.becomeFirstResponder()
//        self.searchController.active = false
        self.tabla.tableHeaderView = self.searchController.searchBar

        
        var shorting: NSSortDescriptor = NSSortDescriptor(key: "sortingAux", ascending: true)
        var shortingName: NSSortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        var shortingNameLast: NSSortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        
        for pe in self.meetingExpositores.persons.sortedArrayUsingDescriptors([shortingName,shortingNameLast,shorting]){
            
            if let a = pe as? Person{
                
                mutuExpo.addObject(a)
                
            }}
        
        

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(self.tabla)
    
        
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 113)
  

        let color = self.meetingExpositores.palette as ColorPalette
        
        view.backgroundColor = UIColor (rgba: color.color2 as String)

        tabla.rowHeight = UITableViewAutomaticDimension
        tabla.estimatedRowHeight = 100
        tabla.backgroundColor = UIColor .clearColor()
        tabla.separatorColor = UIColor .clearColor()
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            
            // Configure countrySearchController
            self.searchController = ({
                // Two setups provided below:
                
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.hidesNavigationBarDuringPresentation = false
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.searchBarStyle = .Minimal
                controller.searchBar.sizeToFit()
                controller.searchBar.translucent = false
                controller.searchBar.backgroundColor = UIColor (rgba: self.meetingExpositores.palette.color4 as String)
                controller.searchBar.barTintColor = UIColor .whiteColor()
                controller.searchBar.tintColor = UIColor .whiteColor()
                controller.searchBar.barStyle = .Black
                return controller
            }())
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var b = UIBarButtonItem(title: "Buscar", style: .Plain, target: self, action: nil)
//        self.navigationItem.rightBarButtonItems = [b]
        self.title = titleView
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                return self.mutuExpo.count ?? 0
            }
            
        } else {
            
            return self.mutuExpo.count ?? 0
        }
    
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var textoLabel1 = "" as NSString!
        var textoLabel2 = "" as NSString!
        var textoLabel3 = "" as NSString!
        var textoLabel4 = "" as NSString!
        var textoLabel5 = "" as NSString!
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen = 60 as CGFloat
        
        var person = Person ()
        
       // let person = mutuExpo.objectAtIndex(indexPath.row) as! Person
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            
            if (self.searchController.active) {

                person = searchArray.objectAtIndex(indexPath.row) as! Person
            } else {
                person = mutuExpo.objectAtIndex(indexPath.row) as! Person
            }
            
        } else {
            person = mutuExpo.objectAtIndex(indexPath.row) as! Person
        }
        
        if(person.isDataAvailable()){
        person.fetchFromLocalDatastoreInBackground()
            
            if person.salutation == "" {
                
                textoLabel1 = "\(person.firstName) \(person.lastName)"
                
            } else {
                
                textoLabel1 = "\(person.salutation) \(person.firstName) \(person.lastName)"
                
            }
       
        if (person.place.isKindOfClass(Place))
        { let placePerson = person.place as Place
            if(placePerson.isDataAvailable()){
            placePerson.fetchFromLocalDatastoreInBackground()

            if(placePerson.name.length != 0){
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    textoLabel2 = placePerson.name
                    
                }
                else if(idioma == "en"){
                    
                    textoLabel2 = placePerson.nameLg2
                }
                    
                else if(idioma == "pt"){
                    
                    textoLabel2 = placePerson.nameLg3
                }
                    
                else{
                    textoLabel2 = placePerson.name
                    
                }
                
            }
            }}}
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        
        var person = Person ()
    
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            
            if (self.searchController.active) {
                person = searchArray.objectAtIndex(indexPath.row) as! Person
            } else {
                person = mutuExpo.objectAtIndex(indexPath.row) as! Person
            }
            
        } else {
            person = mutuExpo.objectAtIndex(indexPath.row) as! Person
        }

        if(person.isDataAvailable()){
        
        person.fetchFromLocalDatastoreInBackground()

        cell.viewContent.backgroundColor = UIColor .whiteColor()
        
        cell.viewContentLeft.constant = 5
        cell.viewContentTop.constant = 5
        cell.viewContentRight.constant = 5
        cell.label1Top.constant = 15
        cell.label5Bot.constant = 15
            
            if person.salutation == "" {
                
              cell.label1.text =  "\(person.firstName) \(person.lastName)"
                
            } else {
                
              cell.label1.text =  "\(person.salutation) \(person.firstName) \(person.lastName)"
                
            }
       
        cell.label1.font = cell.fontTextoGrande

       if (person.place.isKindOfClass(Place))
       { let placePerson = person.place as Place
        if(placePerson.isDataAvailable()){
        placePerson.fetchFromLocalDatastoreInBackground()
        if(placePerson.name.length != 0){
            
            
            let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
            if(idioma == "es")
            {
                cell.label5.text = placePerson.name as String
                
            }
            else if(idioma == "en"){
                
                cell.label5.text = placePerson.nameLg2 as String
            }
                
            else if(idioma == "pt"){
                
                cell.label5.text = placePerson.nameLg3 as String
            }
                
            else{
                cell.label5.text = placePerson.name as String
                
            }
        
            cell.label5.font = cell.fontTextoPequeño
        }
        }}
        
        let profileFoto = person.profileImage as MobiFile
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
        }
    }
        cell.imagenLeft.constant = 5
        cell.imagen.layer.cornerRadius = 50/2
        cell.imagen.clipsToBounds = true
        cell.imagenHeight.constant = 50
        cell.imagenWidth.constant = 50
        
        return cell

    }
    
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.tabla.deselectRowAtIndexPath(indexPath, animated: true)
    
    if(self.searchController.active){
    let person = searchArray.objectAtIndex(indexPath.row) as! Person
    let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("expositoresDetalleViewController") as! expositoresDetalleViewController
            
            if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
                
                self.searchController.active = false
                
            }
        
        detalle.persona = person
        detalle.evento = meetingExpositores
        self.navigationController?.pushViewController(detalle, animated: true)
    }
    else{
        let person = mutuExpo.objectAtIndex(indexPath.row) as! Person
        let detalle = self.storyboard?.instantiateViewControllerWithIdentifier("expositoresDetalleViewController") as! expositoresDetalleViewController
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            
            self.searchController.active = false
            
        }
        
        detalle.persona = person
        detalle.evento = meetingExpositores
        self.navigationController?.pushViewController(detalle, animated: true)

    }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 8) {
            searchController.active = false
        }
    }
    
  }

extension expositoresViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        
        let searchPredicate = NSPredicate(format: "(firstName contains[cd] %@) OR (lastName contains[cd] %@)", searchController.searchBar.text,searchController.searchBar.text)
        let array = self.mutuExpo.filteredArrayUsingPredicate(searchPredicate)
        
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
        self.searchArray = mutuExpo
        self.tabla.reloadData()
    }
    
}
