//
//  ViewController.swift
//  Prism Niligo
//
//  Created by amirhosein on 4/27/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit

class FadeVC: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fadeTextField.delegate=self ;
        timeTextField.delegate=self ;
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let lampConfig=self.tabBarController  as!  lampTabBarController
        self.myColor = lampConfig.color
        if(lampConfig.turnOn == true){
        self.view.backgroundColor = myColor ;
        }else{
            self.view.backgroundColor = UIColor.gray ;
        }
    }
    
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var fadeTextField: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    
    var myColor=UIColor.white ;
    var fade = 0.0
    var time = 0.0
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       
//          self.myColor=self.lampConfig.color ;
//        
//        // Hide the keyboard.
//        if(textField==self.fadeTextField) {
//            
//            self.lampConfig.fade=Double(textField.text!)! ;
//            self.timeTextField.becomeFirstResponder() ;
//        }else {
//            self.lampConfig.time=Double(textField.text!)! ;
//        }
        self.textFieldDidEndEditing(textField)
        textField.resignFirstResponder()
        return true ;
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let lampConfig=self.tabBarController  as!  lampTabBarController
        self.myColor=lampConfig.color ;
        
        if(textField==self.fadeTextField){
            
            let fadeTime=NumberFormatter().number(from: textField.text!)!.floatValue
            lampConfig.fade = Int((textField.text!))! ;
          
            
        UIView.animate(withDuration: TimeInterval(fadeTime), delay: 0.0, animations: {
            self.view.backgroundColor = self.myColor
                }, completion:nil)
        }
        if(textField==self.timeTextField){
            
           
            var delayTime=Int((textField.text! as NSString ).floatValue) ;
            lampConfig.time=Int(textField.text!)!;
            
        }
    }

    }


