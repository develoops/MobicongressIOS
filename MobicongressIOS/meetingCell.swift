//
//  meetingCell.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 07-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class meetingCell: UITableViewCell {
    
    @IBOutlet var separator: UIImageView!
    
    @IBOutlet var fav: UIImageView!
    @IBOutlet var favHeight: NSLayoutConstraint!
    @IBOutlet var favWidth: NSLayoutConstraint!
    
    @IBOutlet var imageFull: UIImageView!

    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewContentLeft: NSLayoutConstraint!
    @IBOutlet var viewContentBot: NSLayoutConstraint!
    @IBOutlet var viewContentRight: NSLayoutConstraint!
    @IBOutlet var viewContentTop: NSLayoutConstraint!

    @IBOutlet var viewInfo: UIView!
    @IBOutlet var viewInfoRight: NSLayoutConstraint!
    @IBOutlet var viewInfoBot: NSLayoutConstraint!
    @IBOutlet var viewInfoTop: NSLayoutConstraint!
    @IBOutlet var viewInfoLeft: NSLayoutConstraint!
    
    @IBOutlet var label1Top: NSLayoutConstraint!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label1Right: NSLayoutConstraint!
    
    @IBOutlet var label2: UILabel!
    @IBOutlet var label2Top: NSLayoutConstraint!
    
    @IBOutlet var label3: UILabel!
    @IBOutlet var label3Top: NSLayoutConstraint!
    
    @IBOutlet var label4: UILabel!
    @IBOutlet var label4Top: NSLayoutConstraint!
    
    @IBOutlet var label5: UILabel!
    @IBOutlet var label5Top: NSLayoutConstraint!
    @IBOutlet var label5Bot: NSLayoutConstraint!
    
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var imagenWidth: NSLayoutConstraint!
    @IBOutlet var imagenHeight: NSLayoutConstraint!
    @IBOutlet var imagenLeft: NSLayoutConstraint!
    @IBOutlet var imagenRight: NSLayoutConstraint!
    @IBOutlet var imagenTop: NSLayoutConstraint!
    @IBOutlet var imagenBot: NSLayoutConstraint!
    
    var textoLabel1 = "" as NSString!
    var textoLabel2 = "" as NSString!
    var textoLabel3 = "" as NSString!
    var textoLabel4 = "" as NSString!
    var textoLabel5 = "" as NSString!
    
    var modoTerminoDeLinea = NSLineBreakMode.ByWordWrapping as NSLineBreakMode!
    var modoJustificado =  NSTextAlignment.Natural as NSTextAlignment!
    
    var fontTextoNegrita = UIFont(name: "Arial-BoldMT", size: 14)
    var fontTextoGrande = UIFont(name: "ArialMT", size: 14)
    var fontTextoMediano  = UIFont(name: "ArialMT", size: 13)
    var fontTextoPequeño = UIFont(name: "ArialMT", size: 12)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        label1.text = ""
        label1.numberOfLines = 0
        label1.textAlignment = modoJustificado
        label1.lineBreakMode = modoTerminoDeLinea
        
        label2.text = ""
        label2.numberOfLines = 0
        label2.textAlignment = modoJustificado
        label2.lineBreakMode = modoTerminoDeLinea
        
        label3.text = ""
        label3.numberOfLines = 0
        label3.textAlignment = modoJustificado
        label3.lineBreakMode = modoTerminoDeLinea
        
        label4.text = ""
        label4.numberOfLines = 0
        label4.textAlignment = modoJustificado
        label4.lineBreakMode = modoTerminoDeLinea
        
        label5.text = ""
        label5.numberOfLines = 0
        label5.textAlignment = modoJustificado
        label5.lineBreakMode = modoTerminoDeLinea
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

