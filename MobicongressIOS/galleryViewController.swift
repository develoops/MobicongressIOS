//
//  galleryViewController.swift
//  MobicongressIOS
//
//  Created by Alfonso Parra Reyes on 4/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class galleryCollectionCell: UICollectionViewCell {
    @IBOutlet var imagen: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class galleryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    private let reuseIdentifier = "galleryCollectionCell"
    
    var meetingGallery:MeetingApp!
    var fotosGaleria = NSMutableArray()
    var imagenGrande = UIImageView()
    var fondo = UIImageView()
    var botonCerrar = UIButton()
    var titleView : String!
    
    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor .redColor()
        
        for obje in meetingGallery.gallery {
            
            if let imagen = obje as? MobiFile{
                
                fotosGaleria.addObject(imagen)
                
            }
            
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotosGaleria.count
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    //1
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            var stand = fotosGaleria.objectAtIndex(indexPath.row) as! MobiFile
            var ancho = CGFloat()
            var alto = CGFloat()
    
            ancho = (self.collection.layer.frame.width / 3) - 2
            alto = (self.collection.layer.frame.height / 3) - 1.5
            
            return CGSize(width: ancho, height: alto)
            
    }
    
    private let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! galleryCollectionCell
        
        var arrayFotos = meetingGallery.gallery.objectAtIndex(indexPath.row) as! MobiFile
        
        let fotoGalery = arrayFotos.parseFileV1
        
        if(arrayFotos.isDataAvailable()){
            arrayFotos.fetchFromLocalDatastoreInBackground()
            
            let ima = arrayFotos.parseFileV1 as PFFile
            ima.getDataInBackgroundWithBlock({
                
                
                (dataImagen, error) -> Void in
                
                if(error != nil){
                    println(error)
                }
                    
                else{
                    
                    println("trae la huea")
                    let image = UIImage(data:dataImagen!)
                    
                    cell.imagen.contentMode = UIViewContentMode.ScaleAspectFit
                    cell.imagen.image = image
                }})
        }
        
        cell.backgroundColor = UIColor .whiteColor()
        
        return cell
    }
    
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
            fondo = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width , self.view.frame.height))
            fondo.backgroundColor = UIColor .blackColor().colorWithAlphaComponent(0.8)
            
            imagenGrande = UIImageView(frame: CGRectMake( 20, 20, self.view.frame.width - 40 , self.view.frame.height - 40))
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! galleryCollectionCell
            
            var arrayFotos = meetingGallery.gallery.objectAtIndex(indexPath.row) as! MobiFile
            
            let fotoGalery = arrayFotos.parseFileV1
            
            if(arrayFotos.isDataAvailable()){
                arrayFotos.fetchFromLocalDatastoreInBackground()
                
                let ima = arrayFotos.parseFileV1 as PFFile
                ima.getDataInBackgroundWithBlock({
                    
                    
                    (dataImagen, error) -> Void in
                    
                    if(error != nil){
                        println(error)
                    }
                        
                    else{
                        
                        println("trae la huea")
                        let image = UIImage(data:dataImagen!)
                        
                        self.imagenGrande.contentMode = UIViewContentMode.ScaleAspectFit
                        self.imagenGrande.image = image
                    }})
            }
            
            botonCerrar   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            botonCerrar.frame = CGRectMake(self.view.frame.width - 50, 10, 30, 30)
            botonCerrar.backgroundColor = UIColor.blackColor()
            botonCerrar.setTitle("X", forState: UIControlState.Normal)
            botonCerrar.setTitleColor(UIColor .whiteColor(), forState: UIControlState.Normal)
            botonCerrar.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            collection.userInteractionEnabled = false
            
            view.insertSubview(fondo, aboveSubview: view)
            view.insertSubview(imagenGrande, aboveSubview: fondo)
            view.insertSubview(botonCerrar, aboveSubview: imagenGrande)
            
        }
    
    func buttonAction(sender:UIButton!)
    {
    
        fondo.removeFromSuperview()
        imagenGrande.removeFromSuperview()
        botonCerrar.removeFromSuperview()
        
        collection.userInteractionEnabled = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Galeria"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}