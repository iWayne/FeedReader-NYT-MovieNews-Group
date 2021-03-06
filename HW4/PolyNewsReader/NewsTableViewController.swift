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
        
        Alamofire.request(.GET, "http://engineering.nyu.edu/poly_pages/api/news", parameters: ["limit": 100])
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
        let img = json[indexPath.row]["image"].string ?? ""
        let teaser = json[indexPath.row]["teaser"].string!
        
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
  
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue"{
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                //let object2 = object[indexPath.row] as NSDate
                //let object2 = object[indexPath.row] as NSDate
                
                  
                let img = json[indexPath.row]["image"].string ?? ""
                let url = NSURL(string: img)
                let object1 = url
                (segue.destinationViewController as DetailViewController).imageItem = object1
                
                let object2 = json[indexPath.row]["teaser"].string!
                (segue.destinationViewController as DetailViewController).detailItem = object2
                
                let object3 = json[indexPath.row]["title"].string!
                (segue.destinationViewController as DetailViewController).titleItem = object3

                            
            }
            
        }
        
        
    }

    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue"{
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                //let object2 = object[indexPath.row] as NSDate
                let object2 = json[indexPath.row]["teaser"].string!
                (segue.destinationViewController as DetailViewController).detailItem = object2
                
            }
            
        }
        
    }*/

}
