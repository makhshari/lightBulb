//
//  NetworkManager.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/9/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import Foundation

class NetworkManager  {

    func networkCall(_ sender:AnyObject ,_ destinationURL : String ,_ serverDictionary: [String: AnyObject]) -> Bool {
        
    var errorFlag = false
    var urlString = URL(string : destinationURL )
    let session = URLSession.shared
    var request = URLRequest(url : urlString! )
    request.httpMethod = "POST" ;

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: serverDictionary, options: .prettyPrinted)
       }
    catch let error {
        print(error.localizedDescription)
        errorFlag = true
        return false
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            print(error ?? 0)
            errorFlag = true
            return
        }
        
        guard let data = data else {
            errorFlag = true
            return
        }
        
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data , options: .mutableContainers ) as? [ String: Any ] {
                print("RESPONSEEE")
                if(destinationURL == "http://192.168.1.40/WebServices/Core.svc/GetState" ){
                    var lampConfig = lampTabBarController()
                    lampConfig = sender as! lampTabBarController
                    lampConfig.manageResponse(json)
                    return
                    }
                else if (destinationURL == "http://192.168.1.40/WebServices/Profile.svc/Login"){
                    var loginViewController = loginVC()
                    loginViewController = sender as! loginVC
                    loginViewController.manageResponse(json)
                }
            }
        } catch let error {
            print("!! DATA FROM SERVER ERROR !! ")
            print(error.localizedDescription)
            errorFlag = true
            return
        }
    })
    task.resume()
    return true
//        if(errorFlag){
//            print("network call error flag")
//            return false
//        }else {
//            return true
//        }
}
    
    func parseJSONFromServer(json : Dictionary<String , Any>, dataModel : lampTabBarController ) {
        
        
    }

}

