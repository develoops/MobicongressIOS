//
//  newsViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 13-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class newsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var newsArra: NSArray!
    var tabla = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        self.tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.backgroundColor = UIColor (rgba: "#d9d9d9")
        self.tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 114)
        self.tabla.separatorColor = UIColor .clearColor()
        self.tabla.frame = self.view.frame
        self.view.addSubview(self.tabla)
        
        self.title = "Novedades"
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat!
        var heightTexto : CGFloat!
        var heightImagen:CGFloat = 0
        
        let newOjeto = self.newsArra.objectAtIndex(indexPath.row) as! New
        newOjeto.fetchFromLocalDatastoreInBackground()
        
        var cell: meetingCell = tabla.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label1.numberOfLines = 0
        label1.lineBreakMode = cell.modoTerminoDeLinea
        label1.font = cell.fontTextoMediano
        label1.text = newOjeto.title as String
        
        let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
        label2.numberOfLines = 0
        label2.lineBreakMode = cell.modoTerminoDeLinea
        label2.font = cell.fontTextoMediano
        label2.text = newOjeto.content as String
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
      return self.newsArra.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        let newOjeto = self.newsArra.objectAtIndex(indexPath.row) as! New
        newOjeto.fetchFromLocalDatastoreInBackground()
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! meetingCell
        
        cell.backgroundColor = UIColor .clearColor()
        cell.viewContent.backgroundColor = UIColor .whiteColor()
        cell.separator.backgroundColor = UIColor .clearColor()
        
        cell.viewContentLeft.constant = 5
        cell.viewContentTop.constant = 5
        cell.viewContentRight.constant = 5
        cell.imagenWidth.constant = 0
        
        cell.label2Top.constant = 5
        
        cell.label1.text = newOjeto.title as String
        cell.label1.font = UIFont(name: "ArialMT", size: 13)
        cell.label2.text = newOjeto.content as String
        cell.label2.font = UIFont(name: "ArialMT", size: 13)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
