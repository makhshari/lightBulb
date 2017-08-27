//
//  ConfigTVC.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/17/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit

class ConfigTVC: UITableViewController {

    
    //MARK: Properties 
     var configDictionary = [String : Any]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        let lampConfig = self.tabBarController as! lampTabBarController
        self.configDictionary = lampConfig.configDictionary
         self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.tag=2
        let lampConfig = self.tabBarController as! lampTabBarController
        self.configDictionary = lampConfig.configDictionary
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.configDictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "configTableViewCell", for: indexPath) as? configTableViewCell else {
             fatalError("The dequeued cell is not an instance of configTableViewCell.")
        }
        
        var myKey = Array(self.configDictionary.keys)[indexPath.row]
        
        cell.configLabel.text = myKey
        var cellDictionary = self.configDictionary[myKey] as! [String : Any]
        var red = ( cellDictionary["Red"] as AnyObject ).integerValue
        var green = ( cellDictionary["Green"] as AnyObject ).integerValue
        var blue = ( cellDictionary["Blue"] as AnyObject ).integerValue
        
        var rowColor = UIColor(red : CGFloat( red! )/255 , green : CGFloat(green!)/255 , blue : CGFloat(blue!)/255 , alpha : 1.0 )
        
        cell.configCircle.layer.borderWidth = 1
        cell.configCircle.layer.masksToBounds = false
        cell.configCircle.layer.cornerRadius = cell.configCircle.frame.height/2
        cell.configCircle.backgroundColor = rowColor
        print("key ",myKey,"is with color : ",rowColor)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myKey = Array(self.configDictionary.keys)[indexPath.row]
        let lampConfig=self.tabBarController as! lampTabBarController
        
        
        lampConfig.dataDictionary = lampConfig.configDictionary[myKey] as! [String : Any]
        lampConfig.attributesUpdate()
    
        
        
        guard ( lampConfig.networkCall(sender: self.view) )else {
              fatalError("network call failed for config")
        }
       
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let myKey = Array(self.configDictionary.keys)[indexPath.row]
            let lampConfig=self.tabBarController as! lampTabBarController
            
            //print("this row has been deleted : ", lampConfig.configDictionary[myKey] as! [String : Any])
            
            self.configDictionary.remove(at: self.configDictionary.index(forKey: myKey)! )
            lampConfig.configDictionary.remove(at: lampConfig.configDictionary.index(forKey: myKey)! )
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
