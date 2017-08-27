//
//  loginVC.swift
//  
//
//  Created by amirhosein on 5/10/1396 AP.
//
//

import Foundation
import UIKit
import TransitionButton

class loginVC : UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("login viewDidLoad")
        usernameTextField.delegate=self
        passwordTextField.delegate=self
        
        self.myButton = TransitionButton(frame: CGRect(x: 0 , y: 0, width: self.buttonView.frame.width, height: self.buttonView.frame.height))
        
        self.buttonView.addSubview(myButton)
        
        
        myButton.backgroundColor = UIColor.yellow
        myButton.setTitle("Connect", for: .normal)
        myButton.cornerRadius = 20
        myButton.spinnerColor = .yellow
        myButton.setTitleColor(UIColor.gray, for: .normal)
        myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        
//        let connectOnImg = UIImage(named : "connect2")
//        connectButton.setImage(connectOnImg, for: .focused)
//        
//        let connectOffImg = UIImage(named : "connect1")
//        connectButton.setImage(connectOnImg, for: .disabled)
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        username = ""
        password = ""
        code = ""
        errorDescription = ""
        sessionKey = ""
    }
    

    @IBOutlet weak var imgLogin: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonView: UIView!
    
    
    
    var myButton = TransitionButton()
    
    var username = ""
    var password = ""
    
    var code = ""
    var errorDescription = ""
    
    var sessionKey = ""
    
    var network = NetworkManager()
    
    var serverDictionary = [String : Any]()
     var dataDictionary = [String: Any]()
    
    let loginRequestURL = "http://192.168.1.40/WebServices/Profile.svc/Login"
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder() ;
        if( textField==usernameTextField) {
            self.username = textField.text!
        }else {
            self.password = textField.text!
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == usernameTextField){
            self.username = textField.text!
        }else{
            self.password = textField.text!
        }
        return true ;
    }
     override func shouldPerformSegue(withIdentifier identifier: String, sender: (Any)? ) -> Bool {
         print("should performe segue ")
        if(code==""){
            print("code is not provided ! ")
            return false
        }
        if(identifier=="loginSegue") {
            if(self.code == "G00000"){
                UserDefaults.standard.set(self.sessionKey , forKey : "sessionKey")
                print("2")
                OperationQueue.main.addOperation  {
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 4: Stop the animation, here you have three options for the `animationStyle` property:
                        // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                        // .shake: when you want to reflect to the user that the task did not complete successfly
                        // .normal
                        self.myButton.stopAnimation(animationStyle: .expand, completion: {
                            //                    let secondVC = SecondViewController()
                            //                    self.present(secondVC, animated: true, completion: nil)
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        })
                    })
                
                }
                return true
        }else {
            print("3")
                OperationQueue.main.addOperation  {
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 4: Stop the animation, here you have three options for the `animationStyle` property:
                        // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                        // .shake: when you want to reflect to the user that the task did not complete successfly
                        // .normal
                           self.myButton.stopAnimation(animationStyle: .shake, completion: {
                            let alertController = UIAlertController(title : "Wrong ! ",message : self.errorDescription ,preferredStyle : .alert)
                            let defaultAction = UIAlertAction(title:"ok" , style : .default , handler : nil) ;
                            alertController.addAction(defaultAction)
                            self.present(alertController,animated: true, completion: nil)
                        })
                    })
                   
                }
                
           return false
        }
        }else{
            print("1")
            return false ;
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("4")
        if segue.identifier == "loginSegue" {
            print("5")
            let vc = segue.destination as! lampTabBarController
            vc.username = self.username ;
        }
    }
    
    func manageResponse (_ json : [String : Any]) {
        print("manage response")
        
        guard let status = json["Status"] as? [String : Any] else {
            return
        }
        guard let parameters = json["Parameters"] as? [String : Any] else {
            
            self.code = status["Code"] as! String
            self.errorDescription = status["Description"] as! String
            
            if(!self.shouldPerformSegue(withIdentifier: "loginSegue",sender : self)){
                print("perform segue failed")
            }
            return
        }
        
        

        self.sessionKey = parameters["SessionKey"] as! String
        self.code = status["Code"] as! String
        self.errorDescription = status["Description"] as! String
        
        if(!self.shouldPerformSegue(withIdentifier: "loginSegue",sender : self)){
                print("perform segue failed")
        }
    }
    
    //MARK: Actions :
    
    @IBAction func buttonAction(_ button: TransitionButton) {
        
        
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
          //  sleep(2) // 3: Do your networking task or background work here.
            self.dataDictionary["Username"] = self.usernameTextField.text
            self.dataDictionary["Password"] = self.passwordTextField.text
            
            self.serverDictionary["Parameters"] = self.dataDictionary ;
            
            print("login server dictionary : ",self.serverDictionary)
            
            if( !self.network.networkCall( self , self.loginRequestURL , self.serverDictionary as [String : AnyObject]) ){
                print("login network call error ")
            }
            

        })
        
    
    }
}
