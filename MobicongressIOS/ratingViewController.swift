//
//  ratingViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 13-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ratingViewController: UIViewController,FloatRatingViewDelegate {

    @IBOutlet var label: UILabel!
    
    @IBOutlet var floatRatingView: FloatRatingView!
    var eventoId: Event!
    var valor = Float()
    var existe = Bool()
    var comentario = UITextField()
    var botonEnviar = UIBarButtonItem()
    var view2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.llamado()

        view2.frame = CGRectMake(0, 0, self.view.layer.frame.width, self.view.layer.frame.height - 64)
        view2.backgroundColor = UIColor.whiteColor()
        
        
        
        
        
        self.estrellitas()
        view.insertSubview(view2, belowSubview: floatRatingView)
        self.comentario.frame = CGRectMake(10, 140, self.view.layer.frame.width - 20, 50)
        self.comentario.borderStyle = .RoundedRect
        self.comentario.textAlignment = .Left
        
        

       
        self.navigationItem.setRightBarButtonItem(self.botonEnviar, animated: true)
        
        self.view.addSubview(self.comentario)
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
//            label.text = "Pulse para calificar"
//            self.title = "Evaluar"
            
            label.text = "Click a STAR to rate"
            self.title = "Review"
            
            //                    self.comentario.placeholder = "Escriba aquí su comentario"
            self.comentario.placeholder = "Type your comment here"
            
//            self.botonEnviar = UIBarButtonItem(title: "Enviar", style: .Plain, target: self, action: "enviar:")
            self.botonEnviar = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "enviar:")
            
        }
        else if(idioma == "en"){
            
            label.text = "Click a STAR to rate"
            self.title = "Review"
            self.botonEnviar = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "enviar:")
            self.comentario.placeholder = "Type your comment here"
        }
            
        else if(idioma == "pt"){
            
            label.text = "Presione las estrellas para calificar"
            self.title = "Evaluar"
            self.comentario.placeholder = "Escreva seu comentário aqui"
            self.botonEnviar = UIBarButtonItem(title: "Mandar", style: .Plain, target: self, action: "enviar:")
        }
            
        else{
            label.text = "Presione las estrellas para calificar"
            self.title = "Evaluar"
            self.comentario.placeholder = "Escriba aquí su comentario"
            self.botonEnviar = UIBarButtonItem(title: "Enviar", style: .Plain, target: self, action: "enviar:")
            
        }
        

        label.textColor = UIColor .lightGrayColor()
        
   
    }
    
    
    func enviar(sender:UIBarButtonItem){
        if(NSUserDefaults.standardUserDefaults().boolForKey("listo")){
        var rating = PFObject(className:"Rating")
        rating["value"] = self.valor
        rating["comment"] = self.comentario.text
        rating["event"] = self.eventoId
      //  var user = PFUser.currentUser()
//        rating.addObject(rating, forKey:"ratings")
        rating.saveInBackgroundWithBlock({ (bol:Bool, error:NSError?) -> Void in
                
                if(error != nil)
                {
                
                }
                else{
                

                }
            })
        }
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    func llamado (){
        
        var query = PFUser.query()
        query!.whereKey("objectId", equalTo:PFUser.currentUser()!.objectId!)
        query!.includeKey("ratings.event")
        var notaC = String()
        var comentarioC = String()
        
       let any = query!.findObjects()
        var ratings = NSArray(array: any!)
        for objeto in ratings {
            let user = objeto as! PFObject
            
            if(user.objectForKey("ratings") != nil){
                let ratero = user.objectForKey("ratings") as! NSArray
                for rating in ratero{
                    
                    let evento = rating.objectForKey("event") as! PFObject
                    
                    if (evento.objectId == self.eventoId.objectId){
                        
                        self.valor = rating.objectForKey("value") as! Float
                        
                        comentarioC = rating.objectForKey("comment") as! NSString as String
                    }}}}
        
        if (comentarioC.isEmpty){
            self.comentario.placeholder = "Comment"
        }
        else{
            self.comentario.text = comentarioC
        }
    }
    func estrellitas(){
        
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = self.valor
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = true
        
    }
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        self.valor = self.floatRatingView.rating
        
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        self.valor = self.floatRatingView.rating
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }
}
