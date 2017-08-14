//
//  NetworkManager.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/9/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import Foundation

class NetworkManager  {

    func networkCall(dataModel : lampTabBarController) -> Bool {

    
    var urlString = URL(string: "http://bulbmanager.simsend.ir/WebServices/Core.svc/SetPowerWithColor")
    if(dataModel.updateState) {
        urlString = URL(string: "http://bulbmanager.simsend.ir/WebServices/Core.svc/GetState")
        }
        
    let session = URLSession.shared
    var request = URLRequest(url : urlString! )
    request.httpMethod = "POST" ;
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dataModel.serverDictionary, options: .prettyPrinted)
    }
    catch let error {
        print(error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data , options: .mutableContainers ) as? [ String: Any ] {
                if(dataModel.updateState){
                    print("server get State response : " , json)
                    
                    guard let parameters = json["Parameters"] as? [String : Any] else {
                        
                        return
                    }
                    dataModel.red = parameters["Red"] as! Int ;
                    
                    dataModel.green = parameters["Green"] as! Int ;
                    dataModel.blue = parameters["Blue"] as! Int ;
                    
                    dataModel.fade = parameters["FadeTime"] as! Int  ;
                    dataModel.turnOn = (parameters["Power"] as! Bool) ;
                    
                    dataModel.updateColor()
                    dataModel.updateState = false ;
                    }
                }
        } catch let error {
            print("!! DATA FROM SERVER ERROR !! ")
            print(error.localizedDescription)
            return
        }
    })
    task.resume()
    return true ;
}
    
    func parseJSONFromServer(json : Dictionary<String , Any>, dataModel : lampTabBarController ) {
        
        
    }

}

