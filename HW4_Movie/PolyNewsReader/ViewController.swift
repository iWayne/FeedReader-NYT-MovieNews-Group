//
//  ViewController.swift
//  PolyNewsReader
//
//  Created by Ardis Kadiu on 4/7/15.
//  Copyright (c) 2015 Spark451. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    var json:JSON = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://engineering.nyu.edu/poly_pages/api/news")
            .responseJSON { (request, response, data, error) in
                //println(request)
                //println(response)
                //println(error)
                
                self.json = JSON(data!)
                
                for (key: String, subJson: JSON) in self.json {
                    let title = subJson["title"].string!
                    let img = subJson["image"].string ?? "no image"
                    
                    println(title)
                    println(img)
                    
                    
                }
                
                
                
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

