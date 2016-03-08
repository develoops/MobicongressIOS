//
//  MCDateFortmatter.swift
//  mobiCongress
//
//  Created by Alfonso Parra Reyes on 12/23/14.
//  Copyright (c) 2014 mobiCongress. All rights reserved.
//

import UIKit

var test = "UTC" as NSString

class MCDateFormatter: NSDateFormatter {
    
    func HorayMinutos() -> NSDateFormatter {
        
        let horaYMinutos = NSDateFormatter()
        horaYMinutos.timeZone = NSTimeZone(name:test as String)
        horaYMinutos.dateFormat = "HH:mm"
        
        return horaYMinutos
       
    }

    func NumeroYDia() -> NSDateFormatter {
        
        let NumeroYDia = NSDateFormatter()
        NumeroYDia.timeZone = NSTimeZone(name:test as String)
        NumeroYDia.dateFormat = "dd EEEE"
        
        return NumeroYDia
        
    }
    
    func NumeroDelDia() -> NSDateFormatter {
        
        let NumeroDelDia = NSDateFormatter()
        NumeroDelDia.timeZone = NSTimeZone(name:test as String)
        NumeroDelDia.dateFormat = "dd"
        
        return NumeroDelDia
        
    }
    
    func DiayMes() -> NSDateFormatter {
        
        let DiayMes = NSDateFormatter()
        DiayMes.timeZone = NSTimeZone(name:test as String)
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            DiayMes.dateFormat = "dd 'de' MMMM"
            DiayMes.locale = NSLocale(localeIdentifier: "es_ES")
            
        }
        else if(idioma == "en"){
            
            DiayMes.dateFormat = "dd 'of' MMMM"
            DiayMes.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            
        }
            
        else if(idioma == "pt"){
            
            DiayMes.dateFormat = "dd 'de' MMMM"
            DiayMes.locale = NSLocale(localeIdentifier: "pt_BR")
        }
            
        else{
            DiayMes.dateFormat = "dd 'de' MMMM"
            DiayMes.locale = NSLocale(localeIdentifier: "es_ES")
            
        }

        
        return DiayMes
        
    }
    func DiaMesAno() -> NSDateFormatter {
        
        let DiaMesAno = NSDateFormatter()
        DiaMesAno.timeZone = NSTimeZone(name:test as String)
        
        let idioma = NSUserDefaults.standardUserDefaults().valueForKey("idioma") as! NSString
        if(idioma == "es")
        {
            DiaMesAno.dateFormat = "dd 'de' MMMM 'de' YYYY"
            DiaMesAno.locale = NSLocale(localeIdentifier: "es_ES")
            
        }
        else if(idioma == "en"){
            
            DiaMesAno.dateFormat = "dd 'of' MMMM 'of' YYYY"
            DiaMesAno.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        }
            
        else if(idioma == "pt"){
            
            DiaMesAno.dateFormat = "de 'de' MMMM 'de' YYYY"
            DiaMesAno.locale = NSLocale(localeIdentifier: "pt_BR")
        }
            
        else{
            DiaMesAno.dateFormat = "dd 'de' MMMM 'de' YYYY"
            DiaMesAno.locale = NSLocale(localeIdentifier: "es_ES")
            
        }
        
        
  
        
        return DiaMesAno
        
    }

}