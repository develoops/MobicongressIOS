//
//  detailView.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 3/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class detailView: UIView {
    
    // tabla1
    
    @IBOutlet var tabla1: UITableView!
    @IBOutlet var tabla1Height: NSLayoutConstraint!
    
    // tabla2
    
    @IBOutlet var tablaConfHeader: UITableView!
    @IBOutlet var tablaConfHeaderHeight: NSLayoutConstraint!
    
    // tabla3
    
    @IBOutlet var tablaHeader: UITableView!
    @IBOutlet var tablaHeaderHeight: NSLayoutConstraint!
    
    // tabla4
    
    @IBOutlet var tablaSpeaker: UITableView!
    @IBOutlet var tablaSpeakerHeight: NSLayoutConstraint!
    
    // tabla5
    
    @IBOutlet var tablaDescripcionHeight: NSLayoutConstraint!
    @IBOutlet var tablaDescripcion: UITableView!
    
    // tabla6
    
    @IBOutlet var tablaEvento: UITableView!
    @IBOutlet var tablaEventoHeight: NSLayoutConstraint!
    @IBOutlet var tablaEventoBot: NSLayoutConstraint!
    @IBOutlet var tablaEventoTop: NSLayoutConstraint!
    @IBOutlet var tablaEventoLeft: NSLayoutConstraint!
    @IBOutlet var tablaEventoRight: NSLayoutConstraint!
    
    // toolBar
    
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var toolBarHeight : NSLayoutConstraint!
    

    
    //
    
    override func awakeFromNib() {
        
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        
        tabla1.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tablaHeader.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tablaConfHeader.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tablaSpeaker.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tablaEvento.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tablaDescripcion.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        tabla1.rowHeight = UITableViewAutomaticDimension
        tabla1.sizeToFit()
        
        tablaHeader.rowHeight = UITableViewAutomaticDimension
        tablaHeader.sizeToFit()
        
        tablaConfHeader.rowHeight = UITableViewAutomaticDimension
        tablaConfHeader.sizeToFit()
        
        tablaSpeaker.rowHeight = UITableViewAutomaticDimension
        tablaSpeaker.sizeToFit()
    
        tablaEvento.rowHeight = UITableViewAutomaticDimension
        tablaEvento.sizeToFit()
        
        tablaDescripcion.rowHeight = UITableViewAutomaticDimension
        tablaDescripcion.sizeToFit()
        
        tabla1Height.constant = 0
        tablaEventoHeight.constant = 0
        tablaSpeakerHeight.constant = 0
        tablaHeaderHeight.constant = 0
        tablaConfHeaderHeight.constant = 0
        tablaDescripcionHeight.constant = 0

    }

    
    
    
}
