//
//  hotelsViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 4/17/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class tripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data:NSData!
    var arr:NSArray!
    var urlPath2:String!
    var meetingApp:MeetingApp!
    var tabla = UITableView()
    var logoTrip = UIImageView()
    var poweredLabel = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        
        var url: NSURL = NSURL(string: urlPath2)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >=nil
        var error: NSErrorPointer = nil
        data =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        arr = jsonResult["data"] as! NSMutableArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "meetingCell", bundle:nil)
        tabla.registerNib(nibName, forCellReuseIdentifier: "Cell")
        
        tabla.rowHeight = UITableViewAutomaticDimension
        tabla.estimatedRowHeight = 100
        
        tabla.dataSource = self
        tabla.delegate = self
        tabla.separatorColor = UIColor .clearColor()
        
        tabla.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 146)
        view.addSubview(self.tabla)
        
        poweredLabel = UILabel(frame: CGRectMake(view.frame.width - 190, view.frame.height - 144, 50, 10))
        poweredLabel.text = "Powered by:"
        poweredLabel.textColor = UIColor .whiteColor()
        poweredLabel.font = UIFont(name: "ArialMT", size: 8)
        view.addSubview(poweredLabel)
        
        logoTrip = UIImageView(frame: CGRectMake(view.frame.width - 140, view.frame.height - 144, 140, 30))
        logoTrip.image = UIImage(named: "tripadvisor")
        logoTrip.backgroundColor = UIColor .whiteColor()
        view.insertSubview(logoTrip, aboveSubview: tabla)
        
        view.backgroundColor  = UIColor (rgba: "#589442")
        tabla.backgroundColor = UIColor (rgba: "#589442")
        tabla.contentInset = UIEdgeInsetsMake(3, 0, 3, 0)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        var lol = arr.objectAtIndex(indexPath.row) as! NSDictionary
        //        let imageUrl:String = lol["rating_image_url"] as NSString
        //        let url = NSURL(string: imageUrl)
        //        let data = NSData(contentsOfURL: url!)
        //        let Uimagen = UIImage(data: data!)
        
        cell.viewInfo.backgroundColor = UIColor .whiteColor()
        cell.imagenWidth.constant = 0
        cell.viewContentLeft.constant = 5
        cell.viewContentRight.constant = 0
        cell.viewContentTop.constant = 0
        cell.viewContentBot.constant = 3
        
        cell.separator.hidden = false
        
        var direccionObjeto = lol["address_obj"] as! NSDictionary
        var direccion = direccionObjeto["address_string"] as! NSString
        var nombre = lol["name"] as! NSString
        //var rating = lol["rating"] as NSString
        
        var lineaTopCelda = UIImageView()
        lineaTopCelda = UIImageView(frame: CGRectMake(0,0,self.view.layer.frame.width,1))
        lineaTopCelda.backgroundColor = UIColor .whiteColor()
        
        cell.addSubview(lineaTopCelda)
        cell.label1.text = nombre as String
        cell.label1.textColor = UIColor .darkGrayColor()
        cell.label1.font = cell.fontTextoNegrita
        cell.label1.preferredMaxLayoutWidth = self.view.layer.frame.width - 30
        
        cell.label2.text = direccion as String
        cell.label2.textColor = UIColor .darkGrayColor()
        cell.label2.preferredMaxLayoutWidth = self.view.layer.frame.width - 30
        cell.label2.font = cell.fontTextoMediano
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell: meetingCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! meetingCell
        
        var lol = arr.objectAtIndex(indexPath.row) as! NSDictionary
        
        let storyboard = UIStoryboard(name: "Meeting", bundle: nil)
        let aWebController = storyboard.instantiateViewControllerWithIdentifier("webViewController") as! webViewController
        
        //        var selectedCell:MCHotelesCell = tableView.cellForRowAtIndexPath(indexPath)! as MCHotelesCell
        //        selectedCell.label.textColor = UIColor .whiteColor()
        //        selectedCell.fondo.backgroundColor = UIColor (rgba: "#589442")
        
        aWebController.stringURL = lol["web_url"] as! NSString
        
        self.navigationController?.pushViewController(aWebController, animated: true)
        
    }
    
    
}