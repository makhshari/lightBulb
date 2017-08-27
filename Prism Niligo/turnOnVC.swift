//
//  ViewController.swift
//  Prism Niligo
//
//  Created by amirhosein on 4/27/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit
import ChromaColorPicker
import SwiftSpinner


class TurnOnVC: UIViewController , UITextFieldDelegate ,  ChromaColorPickerDelegate , UINavigationControllerDelegate {
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        
        self.myColor = colorPicker.currentColor
        let lampConfig=self.tabBarController  as!  lampTabBarController
        lampConfig.color = colorPicker.currentColor
        if(lampConfig.turnOn==true) {
            if(lampConfig.networkCall(sender:self.view)==true) {
                UIView.animate(withDuration: TimeInterval(lampConfig.fade/1000), delay: TimeInterval(lampConfig.time), animations: {
                    self.view.backgroundColor = self.myColor
                }, completion:nil)
            }else {
                print ("Network Call Failed ! ")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let height: CGFloat = 200 //whatever height you want
//        self.navigationController?.navigationBar.frame.size.height = height
//       // self.navBar = CGRect(x: 0, y: 0, width: view.frame.width , height: height)
        
         print("TurnOnVC -- view did APPEAR")
        
       sleep(2)
        self.updateState()
    
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("turnOnVC viewDidLoad")
        self.view.tag = 0
        
        colorPicker.delegate = self
        self.view.addSubview(colorPicker)
        
        
        fadeTextField.delegate=self
        timeTextField.delegate=self
        
        
      
    }
     override func viewWillAppear(_ animated: Bool) {
        
        print("TurnOnVC view will appear")
        
         SwiftSpinner.show( duration: 1.5 , title: "Getting the Bulb's' Latest State")
        
        
          //SwiftSpinner.hide()
       
     
        
    }



    
    @IBOutlet weak var turnOnButton: UISwitch!
    
    @IBOutlet weak var navBackItem: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var fadeTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    

  
    
    var configDictionary = [String : Any]()
    var colorPicker : ChromaColorPicker
    var myColor = UIColor() ;
    
    init() {
    
        let screenSize: CGRect = UIScreen.main.bounds
        colorPicker = ChromaColorPicker(frame: CGRect(x: Int(0.05 * screenSize.width) , y: 60, width: Int(0.9 * screenSize.width), height: Int(0.9 * screenSize.width)))
        //ChromaColorPickerDelegate
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.hexLabel.textColor = UIColor.lightGray
        
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        colorPicker = ChromaColorPicker(frame: CGRect(x: Int(0.05 * screenSize.width) , y: 60, width: Int(0.9 * screenSize.width), height: Int(0.9 * screenSize.width)))
        //ChromaColorPickerDelegate
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.hexLabel.textColor = UIColor.lightGray
        

        super.init(coder: aDecoder)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateState () {
         let lampConfig=self.tabBarController  as!  lampTabBarController
        
                    self.myColor = lampConfig.color
                    print("update state ")
                    self.myColor = lampConfig.color
                    colorPicker.adjustToColor(self.myColor )
                    if(lampConfig.turnOn == true){
                        self.turnOnButton.setOn(true, animated: false)
                        self.view.backgroundColor = self.myColor ;
                    }else{
                        self.turnOnButton.setOn(false, animated: false)
                        self.view.backgroundColor = UIColor.white ;
                }
                 self.navBar.title = lampConfig.username
                return
        }
    
    
    //MARK: Actions :
    
    @IBAction func toAddFav(_ sender: UIButton) {
         let lampConfig = self.tabBarController as! lampTabBarController
        print("data dictionary :",lampConfig.dataDictionary)
        let alertController = UIAlertController(title : "Enter the name of this configuration : ",message :nil ,preferredStyle : .alert)
        let leftAction = UIAlertAction(title:"cancel" ,
                                       style :UIAlertActionStyle.cancel ,
                                       handler : nil ) ;
        
        let rightAction = UIAlertAction(title:"Add" ,
                                        style :UIAlertActionStyle.default ){
                                            (action:UIAlertAction!)in
                                            lampConfig.configDictionary[(alertController.textFields?[0].text)!] = lampConfig.dataDictionary as [String : AnyObject] ;
                                            print("config dictionary :",lampConfig.configDictionary)
                                       
                                            
        }
        alertController.addTextField { (myTextField) in
            myTextField.borderStyle=UITextBorderStyle.none
            myTextField.placeholder = "Favourite name"
        }
        alertController.addAction(leftAction)
        alertController.addAction(rightAction)
        self.present(alertController,animated: true, completion: nil)
    }

    @IBAction func toLogOut(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title : "Log Out ? ",message :nil ,preferredStyle : .alert)
        let leftAction = UIAlertAction(title:"cancel" ,
                                       style :UIAlertActionStyle.cancel ,
                                       handler : nil ) ;
        
        let rightAction = UIAlertAction(title:"Log Out" ,
                                        style :UIAlertActionStyle.destructive){
                                            (action:UIAlertAction!)in
                 //UserDefaults.standard.removeObject(forKey : "sessionKey")
                self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                            
        }
        alertController.addAction(leftAction)
        alertController.addAction(rightAction)
        self.present(alertController,animated: true, completion: nil)
       
    }
    
    @IBAction func turnOnLamp(_ sender: UISwitch) {
        
         let lampConfig=self.tabBarController  as!  lampTabBarController
        
        if(lampConfig.updateState){
            print("config of lamp is not available !")
            return
        }
        if(turnOnButton.isOn){
            lampConfig.turnOn=true;
//            self.myColor = lampConfig.color

            UIView.animate(withDuration: TimeInterval(lampConfig.fade/1000) , delay: TimeInterval(lampConfig.time), animations: {
                self.view.backgroundColor = self.myColor
            }, completion:nil)
            
        }else {
             lampConfig.turnOn=false;
             UIView.animate(withDuration: 0.0 , delay:TimeInterval(lampConfig.time) , animations: {
                self.view.backgroundColor = UIColor.white
            }, completion:nil)
        }
        if(lampConfig.networkCall(sender:self.view)==true) {
            print("\n button network call ! \n")
        }else {
            print ("\n could not network call ")
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textFieldDidEndEditing(textField)
        textField.resignFirstResponder()
        return true ;
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let lampConfig=self.tabBarController  as!  lampTabBarController
        

        if(!(textField.text?.isNumber)!){
            print("invalid textField")
            return
        }
        
        self.myColor=lampConfig.color ;
        
        if(textField==self.fadeTextField){
            
            let fadeTime=Int(textField.text!)
            lampConfig.fade = fadeTime! ;
            
        }
        if(textField==self.timeTextField){
            
            let delayTime=Int(textField.text!) ;
            lampConfig.time=delayTime!;
            
        }
        if(lampConfig.networkCall(sender:self.view)==true) {
            
        }else {
            print ("\n could not network call")
        }
    }
    
}

    extension UINavigationBar {
        open override func sizeThatFits(_ size: CGSize) -> CGSize {
            print("sizeThatFits")
            return CGSize(width:UIScreen.main.bounds.width , height: 300)
        }
    }
    extension String  {
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}

