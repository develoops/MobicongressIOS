//
//  libraryViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 09-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class libraryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var meetingLibrary: NSArray!
    var tabla = UITableView()
    var titleView : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        self.tabla.backgroundColor = UIColor (rgba: "#e0e0e0")
        
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.separatorColor = UIColor .clearColor()
        self.tabla.frame = self.view.frame
        self.view.addSubview(self.tabla)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = titleView

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(self.meetingLibrary.count != 0){
            return self.meetingLibrary.count ?? 0
        }
        else{
        return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 0
        
        var cell: meetingCell = tabla.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        let file = self.meetingLibrary.objectAtIndex(indexPath.row) as! MobiFile
        if(file.isDataAvailable()){
            file.fetchFromLocalDatastoreInBackground()
        }
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoGrande
        label1.text = file.title as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoPequeño
        label2.text = "\(file.size) MB" as String
        
        let label3:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label3.numberOfLines = 0
        label3.lineBreakMode = cell.modoTerminoDeLinea
        label3.font = cell.fontTextoMediano
        label3.text = ""
        
        let label4:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label4.numberOfLines = 0
        label4.lineBreakMode = cell.modoTerminoDeLinea
        label4.font = cell.fontTextoMediano
        label4.text = ""
        
        let label5:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label5.numberOfLines = 0
        label5.lineBreakMode = cell.modoTerminoDeLinea
        label5.font = cell.fontTextoMediano
        label5.text = ""
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        label4.sizeToFit()
        label5.sizeToFit()
        
        heightTexto = label1.frame.height + label2.frame.height + label3.frame.height + label4.frame.height + label5.frame.height + 30
        
        if (heightTexto > heightImagen) {
            height = heightTexto
        } else {
            height = heightImagen + 10
        }
    
        return height
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let file = self.meetingLibrary.objectAtIndex(indexPath.row) as! MobiFile
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        file.fetchFromLocalDatastoreInBackground()

        cell.viewContent.backgroundColor = UIColor .whiteColor()

        cell.viewContentLeft.constant = 5
        cell.viewContentTop.constant = 5
        cell.viewContentRight.constant = 5
        
        cell.imagenWidth.constant = 0
        cell.imagenHeight.constant = 0
        
        cell.viewInfoTop.constant = 5
        cell.viewInfoBot.constant = 5
        
        cell.label1.text = file.title as String
        cell.label1.font = cell.fontTextoGrande
        
        cell.label2.text = "\(file.size) MB" as String
        cell.label2.font = cell.fontTextoPequeño
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let file = self.meetingLibrary.objectAtIndex(indexPath.row) as! MobiFile

    let filesVC = self.storyboard?.instantiateViewControllerWithIdentifier("filesViewController") as! filesViewController
        
        // ARREGLAR
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            

//             filesVC.texto = "Cargando \(file.title)"
            filesVC.texto = "Loading \(file.title)"
            
        }
        else if(idioma == "en"){
            
            
            filesVC.texto = "Loading \(file.title)"
            
        }
            
        else if(idioma == "pt"){
            
            filesVC.texto = "Cargando \(file.title)"
            
            
        }
            
        else{
            
            filesVC.texto = "Cargando \(file.title)"
            
        }
        
        if(file.parseFileV1.url != nil){
 
            filesVC.urling = file.parseFileV1.url
           
        }
        else if (file.urlSource.length != 0){

            filesVC.urling = file.urlSource
            
        }
        else {
            
        println("cuando no hay niuna huea")
        }
        self.navigationController?.pushViewController(filesVC, animated: true)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
