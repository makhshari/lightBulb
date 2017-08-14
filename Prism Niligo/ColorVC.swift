//
//  ViewController.swift
//  Prism Niligo
//
//  Created by amirhosein on 4/27/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit

class ColorVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

       // colorTextField.delegate=self ;
    }
    
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
 
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    
    var selectedColor = UIColor.white
    var hexColorString="" ;
    
    var red : CGFloat = 0.0  ;
    var blue : CGFloat=0.0 ;
    var green : CGFloat=0.0 ;
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Actions
    
    
    @IBAction func redSliderChange(_ sender: UISlider){
        self.previewColor() ;
    }
    
    @IBAction func greenSliderChange(_ sender: UISlider) {
        self.previewColor() ;
    }
  
    @IBAction func blueSliderChange(_ sender: UISlider) {
        self.previewColor() ;
    }
    
    
    @IBAction func applyChanges(_ sender: UIButton) {
        let red255=Int(self.red*255) ;
        let blue255=Int(self.blue*255) ;
        let green255=Int(self.green*255) ;
        
        let redHex = String(format:"%02X", red255) ;
        let blueHex=String(format:"%02X",blue255) ;
        let greenHex=String(format:"%02X",green255) ;
        
        hexColorString=redHex+greenHex+blueHex
        
        
        
        let lampConfig=self.tabBarController  as!  lampTabBarController
        lampConfig.color = self.selectedColor
        if(lampConfig.turnOn==true) {
        print ("*** Network Call from ColorVC ! ")
            if(lampConfig.networkCall(sender:self)==true) {
            print ("^^^ Network Call from ColorVC ! ")
        }else {
            print ("could not network call in colorVC")
        }
        }
        
        

    }
    //MARK: - instance methods
    func previewColor(){
        self.red    = CGFloat(redSlider.value)
        self.blue = CGFloat(blueSlider.value)
        self.green = CGFloat(greenSlider.value)
        self.selectedColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
        
            self.sampleLabel.backgroundColor=self.selectedColor
        
        
    }
    
    
}

