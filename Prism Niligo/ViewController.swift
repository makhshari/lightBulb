//
//  ViewController.swift
//  Prism Niligo
//
//  Created by amirhosein on 4/27/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fadeTextField.delegate=self ;
        colorTextField.delegate=self ;
    }

   
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var turnOnButton: UISwitch!
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var fadeTextField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorTextField: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true ;

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(textField==self.fadeTextField){
            var fadeTime=0 ;
            fadeTime=Int(textField.text!)! ;
            print("fade time updated to : ",fadeTime) ;
        }
        else if (textField==self.colorTextField){
            var colorRGB="" ;
            colorRGB=textField.text!  ;
            print("color RGB updated to : ",colorRGB) ;
        }
    }
    
    
    
    //MARK: Actions :
  
    @IBAction func turnOnLamp(_ sender: UISwitch) {
        if(turnOnButton.isOn){
            statusLabel.text="Turned On !"
        }else {
            statusLabel.text="Turned off !"
        }
        
    }

}
