//
//  DataModel.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/3/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit;

class DataModel  {

    var myColor  = UIColor.cyan
    var myTurnOn = false
    var myFade = 0.0
    var myTime = 0.0
    
    var dataDictionary = [String: Any]()
    
    
    func serialize(color:UIColor , turnOn : Bool , fade : Double , time : Double) -> JSONSerialization {
        
            self.myColor = color
            self.myTurnOn = turnOn
            self.myFade = fade
            self.myTime = time
        
            dataDictionary["myColor"] = self.myColor ;
            dataDictionary["myTurnOn"] = self.myTurnOn ;
            dataDictionary["myFade"] = self.myFade ;
            dataDictionary["myTime"] = self.myTime ;
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
             var decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            return decoded as! JSONSerialization ;
            
            // you can now cast it with the right type
        
        } catch {
            print(error.localizedDescription)
            
            return error as! JSONSerialization
        }
        
       
    }

}
