//
//  todoViewController.swift
//  ParseStarterProject
//
//  Created by Arturo Sanhueza on 24-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class othersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
        var companyAboutInfo: Facade!
    var companyInfo:CompanyApp!
        var confVista: View!
        var detailEventView = NSBundle.mainBundle().loadNibNamed("detailView", owner: nil, options: nil)[0] as! detailView
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            detailEventView.tablaHeader.delegate = self
            detailEventView.tablaHeader.dataSource = self
            detailEventView.tablaSpeaker.delegate = self
            detailEventView.tablaSpeaker.dataSource = self
            detailEventView.tablaEvento.delegate = self
            detailEventView.tablaEvento.dataSource = self
            detailEventView.tablaDescripcion.delegate = self
            detailEventView.tablaDescripcion.dataSource = self
            
            view.backgroundColor = UIColor (rgba: companyInfo.palette.color2 as String)
            
            detailEventView.frame = CGRectMake(0, 0, view.layer.frame.width, view.layer.frame.height - 110)
            
            view.addSubview(detailEventView)
            
//            detailEventView.toolBar.translucent = false
//            detailEventView.toolBar.barTintColor = UIColor (rgba: companyInfo.palette.color4)
//            detailEventView.toolBar.tintColor = UIColor .whiteColor()
            
                   }
        
        
        override func viewDidLayoutSubviews() {
            
            detailEventView.tablaHeaderHeight.constant = detailEventView.tablaHeader.contentSize.height
            detailEventView.tablaDescripcionHeight.constant = detailEventView.tablaDescripcion.contentSize.height
            
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if (tableView == detailEventView.tablaHeader) {
                
                return 1
            }
            
            if (tableView == detailEventView.tablaDescripcion) {
                
                return 1
            }
            
            if (tableView == detailEventView.tablaSpeaker) {
                
                return 0
            }
            if (tableView == detailEventView.tablaEvento) {
                
                return 0
            }
            
            return 1
        }
        
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
            var textoLabel1 = "" as NSString!
            var textoLabel2 = "" as NSString!
            var textoLabel3 = "" as NSString!
            var textoLabel4 = "" as NSString!
            var textoLabel5 = "" as NSString!
            
            var height:CGFloat!
            var heightTexto : CGFloat!
            var heightImagen:CGFloat = 80
            
            if (tableView == detailEventView.tablaHeader) {
                
                textoLabel1 = self.companyAboutInfo.company.name
                
            }
            
            if (tableView == detailEventView.tablaDescripcion) {
                
                textoLabel2 = self.companyAboutInfo.company.details
                
            }
            
            var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
            
            let label1:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
            label1.numberOfLines = 0
            label1.lineBreakMode = cell.modoTerminoDeLinea
            label1.font = cell.fontTextoGrande
            label1.text = textoLabel1 as String
            
            let label2:UILabel = UILabel(frame: CGRectMake(0, 0, cell.frame.width, CGFloat.max))
            label2.numberOfLines = 0
            label2.lineBreakMode = cell.modoTerminoDeLinea
            label2.font = cell.fontTextoMediano
            label2.text = textoLabel2 as String
            
            let label3:UILabel = UILabel(frame: CGRectMake(0, 0,cell.frame.width, CGFloat.max))
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
                
                cell.backgroundColor = UIColor (rgba: companyInfo.palette.color4 as String)
                
                cell.label1Top.constant = 35
                
                cell.label1.text = self.companyAboutInfo.company.name as String
                cell.label1Right.constant = 15
                cell.label1.textColor = UIColor .whiteColor()
                cell.label1.font = UIFont(name: "ArialMT", size: 16)
             
                if !(self.companyAboutInfo.company.logo.parseFileV1.getData() == nil) {
                    
                    cell.imagen.backgroundColor = UIColor .whiteColor()
                    cell.imagen.image = UIImage(data: self.companyAboutInfo.company.logo.parseFileV1.getData()!)
                    cell.imagenTop.constant = 0
                    cell.imagenBot.constant = 0
                    cell.imagenHeight.constant = 90
                    cell.imagenWidth.constant = 90
                    cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                    
                } else {
                    cell.imagenWidth.constant = 0
                }

            }
            
            if (tableView == detailEventView.tablaDescripcion) {
                let color = self.companyInfo.palette as ColorPalette
                
                cell.viewContentLeft.constant = 10
                cell.viewContentTop.constant = 5
                cell.viewContentRight.constant = 10
                cell.viewContentBot.constant = 5
                
                cell.label2.text = companyAboutInfo.company.details as String
                cell.label2.font = UIFont(name: "ArialMT", size: 13)
                cell.imagenWidth.constant = 0
                
                
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