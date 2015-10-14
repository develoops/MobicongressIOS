//
//  sponsorsViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 26-02-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class standCollectionCell: UICollectionViewCell {
    @IBOutlet var imagen: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class sponsorsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    private let reuseIdentifier = "standCollectionCell"
    
    var meetingSponsors:MeetingApp!
    var stands = NSMutableArray()
    var imagenGrande = UIImageView()
    var fondo = UIImageView()
    var botonCerrar = UIButton()
    var puntoX:NSNumber!
    var puntoY:NSNumber!
    var planoImagen:UIImage!
    var scrollView:UIScrollView!
    var imageView:UIImageView!
    var titleView:String!
    
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet var toolBarHeight: NSLayoutConstraint!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if !(meetingSponsors.headerImage.parseFileV1.getData() == nil) {
        
        // significa que el mapa comercial va en el boton y hay sponsors
        // headerImage es el mapa Comercial
        // headerVideo es la imagen de hoteles
        
        self.title = titleView
        
        meetingSponsors.headerImage.parseFileV1.getDataInBackground().continueWithBlock { (task:BFTask!) -> AnyObject! in
            
            if(task.result != nil){
            self.crearHuea()
            self.toolBar.translucent = false
            self.toolBar.barTintColor = UIColor (rgba: self.meetingSponsors.palette.color4 as String)
            self.toolBar.tintColor = UIColor.whiteColor()
            self.toolBarHeight.constant = 44
            
            }
            else{
                self.toolBarHeight.constant = 0

            }
            return task

        }
        
        if !(meetingSponsors.headerVideo.parseFileV1.getData() == nil) {
            
            self.crearHuea2()
            topBarHeight.constant = 44
            topBar.translucent = false
            topBar.barTintColor = UIColor (rgba: meetingSponsors.palette.color4 as String)
            topBar.tintColor = UIColor.whiteColor()
            
        } else {
            
            topBarHeight.constant = 0
            
        }
        
        for obje in meetingSponsors.companies {
            
            if let company = obje as? Facade{
                
                stands.addObject(company)
                
            }}
        
        //       }
        //            else {
        //
        //            // significa que el mapa comercial como IMAGEN va en la vista
        //            // headerVideo se carga en la vista!
        //
        //            self.title = "Mapa Comercial"
        //
        //            toolBarHeight.constant = 0
        //
        //            scrollView = UIScrollView(frame: CGRectMake(0, -48, self.view.layer.frame.width, self.view.layer.frame.height - 8))
        //            scrollView.delegate = self
        //            scrollView.backgroundColor = UIColor .blackColor()
        //            view.backgroundColor = UIColor .blackColor()
        //
        //            if !(meetingSponsors.headerVideo.parseFileV1.getData() == nil) {
        //
        //                planoImagen = UIImage(data: meetingSponsors.headerVideo.parseFileV1.getData()!)
        //
        //                imageView = UIImageView(image: planoImagen)
        //                imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:planoImagen.size)
        //                scrollView.addSubview(imageView)
        //                //            var pin = UIImageView(image: UIImage(named: "pin"))
        //                //            pin.frame = CGRectMake(imageView.layer.frame.width * CGFloat(puntoX), imageView.layer.frame.height * CGFloat(puntoY), 60  , 60)
        //
        //                // 2
        //                scrollView.contentSize = planoImagen.size
        //
        //                // 3
        //                var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        //                doubleTapRecognizer.numberOfTapsRequired = 2
        //                doubleTapRecognizer.numberOfTouchesRequired = 1
        //                scrollView.addGestureRecognizer(doubleTapRecognizer)
        //
        //                // 4
        //                let scrollViewFrame = scrollView.frame
        //                let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        //                let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        //                let minScale = min(scaleWidth, scaleHeight);
        //                scrollView.minimumZoomScale = minScale;
        //
        //                // 5
        //                scrollView.maximumZoomScale = 2.0
        //                scrollView.zoomScale = minScale;
        //
        //                // 6
        //
        //                scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50
        //                    , right: 0)
        //                centerScrollViewContents()
        //
        //            }
        //
        //            //            imageView.addSubview(pin)
        //            view.addSubview(scrollView)
        //            collection.removeFromSuperview()
        //
        //        }
        
        
    }
    
    func crearHuea(){
        
        var mutu = NSMutableArray()
        var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var item = UIBarButtonItem()
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {

//             item = UIBarButtonItem(title:"Mapa Comercial" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor:")
            
            item = UIBarButtonItem(title:"Commercial Map" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor:")
            
        }
        else if(idioma == "en"){
            

            item = UIBarButtonItem(title:"Commercial Map" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor:")
            
        }
            
        else if(idioma == "pt"){
            

            item = UIBarButtonItem(title:"Mapa Negocios" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor:")
            
        }
            
        else{
            
            item = UIBarButtonItem(title:"Mapa Comercial" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor:")
            

            
        }
        

        item.width = (view.frame.width / 1.1)
        mutu.addObject(item)
        
        toolBar.items = mutu as [AnyObject]
        toolBar.hidden = false
        
    }
    
    func funRoomSponsor(sender: UIBarButtonItem) {
        var mapaVc = self.storyboard?.instantiateViewControllerWithIdentifier("mapaViewController") as! mapaViewController
        
        
        meetingSponsors.headerImage.fetchFromLocalDatastoreInBackground()
        var image = UIImage (data: meetingSponsors.headerImage.parseFileV1.getData()!, scale: 3.0)
        
        mapaVc.planoImagen = image
        mapaVc.puntoX = -50
        mapaVc.puntoY = -50
        
        self.navigationController?.pushViewController(mapaVc, animated: true)
        
    }
    
    func crearHuea2(){
        
        var mutu = NSMutableArray()
        var flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        var item = UIBarButtonItem(title:"Hoteles" as String, style: UIBarButtonItemStyle.Plain, target: self, action:"funRoomSponsor2:")
        item.width = (view.frame.width / 1.1)
        mutu.addObject(item)
        
        topBar.items = mutu as [AnyObject]
        topBar.hidden = false
        
    }
    
    func funRoomSponsor2(sender: UIBarButtonItem) {
        var mapaVc = self.storyboard?.instantiateViewControllerWithIdentifier("mapaViewController") as! mapaViewController
        
        
        meetingSponsors.headerImage.fetchFromLocalDatastoreInBackground()
        var image = UIImage (data: meetingSponsors.headerVideo.parseFileV1.getData()!, scale: 3.0)
        
        mapaVc.planoImagen = image
        mapaVc.puntoX = -50
        mapaVc.puntoY = -50
        
        self.navigationController?.pushViewController(mapaVc, animated: true)
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stands.count
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    //1
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            var stand = stands.objectAtIndex(indexPath.row) as! Facade
            var ancho = CGFloat()
            var alto = CGFloat()
            
            if (stand.role == "mapaComercial") {
                
                ancho = self.collection.layer.frame.width
                alto = self.collection.layer.frame.height
                
            }
            
            
            if (stand.role == "sponsorPlatinum") {
                
                ancho = self.collection.layer.frame.width
                alto = self.collection.layer.frame.height
                
            }
                
            else  if (stand.role == "sponsorGold") {
                
                ancho = self.collection.layer.frame.width - 20
                alto = (self.collection.layer.frame.height / 3) - 1.5
                
            }
                
            else   if (stand.role == "sponsorSilver"){
                
                ancho = (self.collection.layer.frame.width / 3) - 2
                alto = (self.collection.layer.frame.height / 3) - 1.5
                
            }
            
            return CGSize(width: ancho, height: alto)
            
    }
    
    private let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! standCollectionCell
        
        var stand = meetingSponsors.companies.objectAtIndex(indexPath.row) as! Facade
        
        let companyFaca = stand.company
        if(companyFaca.isDataAvailable()){
            companyFaca.fetchFromLocalDatastoreInBackground()
            
            if (companyFaca.logo.isDataAvailable()) {
                companyFaca.logo.fetchFromLocalDatastoreInBackground()
                
                let ima = companyFaca.logo.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({
                    
                    (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)
                    }
                        
                    else{
                        
                        let image = UIImage(data:dataImagen!)
                        
                        cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                        cell.imagen.image = image
                    }})
                
            }
        }
        else {
            
            cell.imagen.image = UIImage (named: "eem")
        }
        
        cell.backgroundColor = UIColor .whiteColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.cellForItemAtIndexPath(indexPath)
        let storyboard = UIStoryboard(name: "Meeting", bundle: nil)
        
        var stand = stands.objectAtIndex(indexPath.row) as! Facade
        
        if stand.company.linkedin == "stand" {
            
            let toStandDetail = storyboard.instantiateViewControllerWithIdentifier("sponsorDetail") as! sponsorDetailViewController
            
            toStandDetail.companyAboutInfo = stand
            toStandDetail.meetingApp = meetingSponsors
            self.navigationController?.pushViewController(toStandDetail, animated: true)

            
        } else if stand.company.linkedin == "web" {
            
            if !(stand.company.website == "") {
                
                let toWebDetail = storyboard.instantiateViewControllerWithIdentifier("filesViewController") as! filesViewController
                toWebDetail.urling = stand.company.website
                
                // ARREGLAR
                
                let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
                if(idioma == "es")
                {
                    
                    //toWebDetail.texto = "Cargando Stand de \(stand.company.name)"
                    toWebDetail.texto = "Loading \(stand.company.name)'s Info"
                    
                }
                else if(idioma == "en"){
                    
                    
                    toWebDetail.texto = "Loading \(stand.company.name)'s Info"
                    
                }
                    
                else if(idioma == "pt"){
                    
                    toWebDetail.texto = "Cargando sitio web de \(stand.company.name)"

                    
                }
                    
                else{
                    
                    toWebDetail.texto = "Cargando sitio web de \(stand.company.name)"
                    
                }
                
                self.navigationController?.pushViewController(toWebDetail, animated: true)
            }
            
        } else {
            
            // no hace nada
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(imageView)
        
        // 2
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // 3
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}