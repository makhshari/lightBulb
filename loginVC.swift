//
//  loginVC.swift
//  
//
//  Created by amirhosein on 5/10/1396 AP.
//
//

import Foundation
import UIKit

class loginVC : UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate=self
        passwordTextField.delegate=self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    

    @IBOutlet weak var imgLogin: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var connectButton: UIButton!
    
    var username = ""
    var password = ""
    
    
    
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
        if(identifier=="loginSegue") {
        if (self.username == "alton" || self.password == "qAzwSxeDc123" ) {
            return true
        }else {
            let alertController = UIAlertController(title : "Wrong ! ",message : "enter the  name and password for the WIFI that bulb is connected to " ,preferredStyle : .alert)
            let defaultAction = UIAlertAction(title:"ok" , style : .default , handler : nil) ;
            alertController.addAction(defaultAction)
            self.present(alertController,animated: true, completion: nil)
            return false
        }
        }else{
            return false ;
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "loginSegue" {
            let vc = segue.destination as! lampTabBarController
            vc.username = self.username ;
        }
    }

    
    
    //MARK: Actions :
    
    @IBAction func toConnect(_ sender: Any) {
       
        
    }
 




}
