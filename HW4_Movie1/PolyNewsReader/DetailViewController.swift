//
//  DetailViewController.swift
//  PolyNewsReader
//
//  Created by Ardis Kadiu on 4/7/15.
//  Copyright (c) 2015 Spark451. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
    var detailItem:AnyObject?
    var titleItem:AnyObject?
    var imageItem:AnyObject?
    var count:Int = 0
    var newsURL:AnyObject?
    var viewFlipsideBackgroundColor:UIColor = UIColor()
    
    @IBAction func shareButton(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(LabelTitle.text! + "\n" + LabelDetail.text! + "\n" + newsURL!.description)
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

            
          /*  var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
           */
            
            
            
        }
        
        
        
        
        
    }
    @IBAction func background(sender: AnyObject) {
        count += 1
        if count % 2 == 1{
            self.view.backgroundColor = UIColor.whiteColor()
            LabelTitle.textColor = UIColor.blackColor()
            LabelDetail.textColor = UIColor.blackColor()
        }
        else{
            self.view.backgroundColor = viewFlipsideBackgroundColor
            LabelTitle.textColor = UIColor.whiteColor()
            LabelDetail.textColor = UIColor.whiteColor()
        }
        
        
        
        
        
    }
    @IBOutlet weak var Bg: UIButton!
    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var ImageP: UIImageView!
    @IBOutlet weak var LabelDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.navigationItem.rightBarButtonItem = self.
 //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    override func viewDidAppear(animated: Bool) {
        if let detail:AnyObject = self.detailItem{
            viewFlipsideBackgroundColor = self.view.backgroundColor!
            LabelDetail.text = detail.description
            LabelTitle.text = titleItem?.description
            
            if  let data = NSData(contentsOfURL: imageItem! as NSURL) {
                ImageP.image = UIImage(data: data)
            }

        }// Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
