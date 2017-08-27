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
    
    var color  = UIColor()
    var turnOn = false
    var fade = 0
    var time = 0
    
    var red = 255 ;
    var green=255 ;
    var blue=255 ;
    
    var configDictionary = [String: [String: AnyObject]]()
    var dataDictionary = [String: Any]()
    var identityDictionary = [String: Any]()
    var serverDictionary = [String : Any]()
    
    var updateState = true ;
    
    var network = NetworkManager() ;
    
    var getStateURL = "http://192.168.1.40/WebServices/Core.svc/GetState"
    var setColorWithPowerURL = "http://192.168.1.40/WebServices/Core.svc/SetPowerWithColor"
    
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
    
    func getState() {
        
        self.identityDictionary["SessionKey"] =  "E6B6D964B966E71180CC4A9D6544D113"
        // self.identityDictionary["SessionKey"] = UserDefaults.standard.string(forKey: "sessionKey") ;
        self.serverDictionary["Identity"] = self.identityDictionary ;
        if(self.updateState) {
            print("11")
            if( !network.networkCall(self , self.getStateURL , serverDictionary as [String : AnyObject] ) ) {
                print("lampConfig network call Failed !!!")
            }
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lampconfig viewDidLoad")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         print("lampconfig viewWillAppear")
        self.getState()
    }
    
    
    func networkCall(sender : AnyObject) -> Bool {
    
        if(sender.tag == 2 ){
            serverDictionary["Parameters"] = dataDictionary ;
            serverDictionary["Identity"] = identityDictionary ;
        }else{
           self.dictionaryUpdate()
        }
        print("\n the server dictionary : \n ",serverDictionary)
        return network.networkCall(self,self.setColorWithPowerURL,serverDictionary as [String : AnyObject] )
    }
    
    func manageResponse(_ responseJson : [String : Any])  {
        
        
        print("GET STATE response json in attributes update \n" , responseJson)
        
        guard let parameters = responseJson["Parameters"] as? [String : Any] else {
            print("parameters is null")
            return
        }
        guard let status = responseJson["Status"] as? [String : Any] else {
            print("status error")
            return
        }
        
        self.red = parameters["Red"] as! Int
        self.green = parameters["Green"] as! Int
        self.blue = parameters["Blue"] as! Int
        
        self.updateColor()
        
        self.fade = parameters["FadeTime"] as! Int  ;
        self.turnOn = parameters["Power"] as! Bool ;
        self.time = 0
        
        self.updateState = false
        
        self.dictionaryUpdate()
        print("12")

        }
    
    func attributesUpdate(){
    
        print("999",dataDictionary)
        print("333",dataDictionary["Red"]!)
        dataDictionary = dataDictionary as [String : Any]
        
        
        self.red = ( dataDictionary["Red"] as AnyObject ).integerValue
        self.green = ( dataDictionary["Green"] as AnyObject ).integerValue
        self.blue = ( dataDictionary["Blue"] as AnyObject ).integerValue
        
        self.updateColor()
        
        self.turnOn = dataDictionary["Power"] as! Bool
        self.fade = dataDictionary["FadeTime"] as! Int
        self.time = dataDictionary["Delay"] as! Int
    }

    
    func dictionaryUpdate()  {
        
        print("dictionary update")
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

