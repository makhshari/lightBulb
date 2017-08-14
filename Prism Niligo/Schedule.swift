//
//  shedule.swift
//  Prism Niligo
//
//  Created by amirhosein on 5/16/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//
//
//  ViewController.swift
//  Prism Niligo
//
//  Created by amirhosein on 4/27/1396 AP.
//  Copyright © 1396 amirhosein. All rights reserved.
//

import UIKit


class Schedule : UIViewController , UITableViewDelegate , UITableViewDataSource  {
    
    let myArray=["ali","amir"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let screenSize: CGRect = UIScreen.main.bounds
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.myArray.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style : UITableViewCellStyle.default , reuseIdentifier : "cell" )
        cell.textLabel?.text = self.myArray[indexPath.row]
        return (cell)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions :
    
    }

