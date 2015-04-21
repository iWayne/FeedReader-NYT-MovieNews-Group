//
//  NewsTableViewController.swift
//  PolyNewsReader
//
//  Created by Ardis Kadiu on 4/7/15.
//  Copyright (c) 2015 Spark451. All rights reserved. 
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsTableViewController: UITableViewController {

    var json:JSON = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://api.nytimes.com/svc/news/v3/content/all/movies/240.json?api-key=19720b5f39bd3d4c5f88a2bad8991410%3A9%3A71899559")
            .responseJSON { (request, response, data, error) in
                //println(request)
                //println(response)
                //println(error)
                
                
                self.json = JSON(data!)
                self.json = self.json["results"]
                
                for (key: String, subJson: JSON) in self.json {
                    let title = subJson["title"].string!
                    let img = subJson["thumbnail_standard"].string ?? "no image"
                    //println(title)
                    //println(img)
                }
                
                self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return json.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as CustomTableViewCell
        
        let title = json[indexPath.row]["title"].string!
        let img = json[indexPath.row]["thumbnail_standard"].string ?? ""
        let teaser = json[indexPath.row]["abstract"].string!
        
        cell.title?.text = title
        //cell.detailTextLabel?.text = teaser
        cell.detailTextLabel?.text = ""
        //cell.titleimage?.frame = CGRectMake(0, 0, 50, 50);
        
        //cell.imageView?.center = imageView.superview.center
        let url = NSURL(string: img)
        if  let data = NSData(contentsOfURL: url!) {
            cell.titleimage?.image = UIImage(data: data)
        }

       // cell.textLabel.text = transportItems[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("detailSegue", sender: self)
        
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue"{
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                var img = ""
                //json[indexPath.row]["thumbnail_standard"].string ?? ""
                let js:JSON = json[indexPath.row]["multimedia"]
                for (key: String, subJson: JSON) in js {
                    img = subJson["url"].string ?? "no image"
                }
                //println("image: "+img)
                let url = NSURL(string: img)
                let object1 = url
                (segue.destinationViewController as DetailViewController).imageItem = object1
                
                let object2 = json[indexPath.row]["abstract"].string!
                (segue.destinationViewController as DetailViewController).detailItem = object2
                
                let object3 = json[indexPath.row]["title"].string!
                (segue.destinationViewController as DetailViewController).titleItem = object3

                let object4 = json[indexPath.row]["url"].string!
                (segue.destinationViewController as DetailViewController).newsURL = object4
            }
            
        }
        
        
    }


}
