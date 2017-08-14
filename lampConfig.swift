//
//  lampConfig.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/2/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit
import Foundation


class lampTabBarController : UITabBarController  {

  

    var username = "Niligo Bulb"
    
    
    var color  = UIColor.cyan
    var turnOn = false
    var fade = 0
    var time = 0
    
    var red = 255 ;
    var green=255 ;
    var blue=255 ;
    
    var configDictionary = [String : Any]()
    var dataDictionary = [String: Any]()
    var identityDictionary = [String: Any]()
    var serverDictionary = [String : Any]()
    
    var updateState = true ;
    
    var network = NetworkManager() ;
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func updateColor() {
      self.color = UIColor(red : CGFloat(self.red)/255 , green : CGFloat(self.green)/255 , blue : CGFloat(self.blue)/255 , alpha : 1.0 )
    }
    
    func showError( str : String ){
        
    }
    
    
    override func viewDidLoad() {
        
        self.identityDictionary["SessionKey"] = "E6B6D964B966E71180CC4A9D6544D113" ;
        self.serverDictionary["Identity"] = self.identityDictionary ;
        
        network.networkCall( dataModel : self )
    }
    
    func networkCall(sender : AnyObject) -> Bool {
    
        if(sender.tag == 2 ){
            serverDictionary["Parameters"] = dataDictionary ;
            serverDictionary["Identity"] = identityDictionary ;
           // attributesUpdate()
        }else{
           self.dictionaryUpdate()
        }
        print("\n the server dictionary : \n ",serverDictionary)
        return network.networkCall(dataModel : self ) ;
    }
    
    func attributesUpdate()  {
        self.red = self.dataDictionary["Red"] as! Int
        self.green = self.dataDictionary["Green"] as! Int
        self.blue = self.dataDictionary["Blue"] as! Int
        
        self.color = UIColor(red : CGFloat(self.red) , green : CGFloat(self.green) , blue : CGFloat(self.blue) , alpha : 1.0 )
        
        self.turnOn = (self.dataDictionary["Power"] != nil)
        self.fade = (self.dataDictionary["FadeTime"] as! Int)
        self.time = (self.dataDictionary["Delay"] as! Int  )
        }

    
    func dictionaryUpdate()  {
        
        red = Int(self.color.Red)!
        green=Int(self.color.Green)!
        blue=Int(self.color.Blue)!
            
        dataDictionary["Red"] = self.color.Red;
        dataDictionary["Green"] = self.color.Green;
        dataDictionary["Blue"] = self.color.Blue;
        dataDictionary["Power"] = self.turnOn ;
        dataDictionary["FadeTime"] = self.fade ;
        dataDictionary["Delay"] = self.time ;
        
        identityDictionary["SessionKey"] = "E6B6D964B966E71180CC4A9D6544D113" ;
        
        serverDictionary["Parameters"] = dataDictionary ;
        serverDictionary["Identity"] = identityDictionary ;
    }
        
    
    }
extension UIColor {
    var hexString : String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    var Red : String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            Int(r * 255)
        )
    }
    var Green : String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
           Int(g * 255)
        )
    }
    var Blue : String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            Int(b * 255)
        )
    }
}

