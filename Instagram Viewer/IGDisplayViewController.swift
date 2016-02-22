//
//  IGDisplayViewController.swift
//  Instagram Viewer
//
//  Created by Alexander Besson on 2016-02-17.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import UIKit
import Alamofire

let accessToken = "86456.577b36b.acec7bbaf4ff4079b866910f48cd0784"
let accessToken2 = "2954906968.ed32126.9dc678fa36de4f518e9a0cb5adbd93e5"
let accessToken3 = "2954906968.ed32126.9dc678fa36de4f518e9a0cb5adbd93e5"
let urlBase = "https://api.instagram.com/v1/users/self/media/recent?access_token="
let urlBase2 = "https://api.instagram.com/v1/users/search?q=snoopdogg&access_token="
let urlEnd = "&scope=public_content"

class IGDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblIGResults: UITableView!
    
    typealias DownloadComplete = ([String], [String]) -> ()
    
    var instagramCaptions = [String]()
    var instagramImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblIGResults.delegate = self
        tblIGResults.dataSource = self
        
        loadPhotos { (images, captions) -> () in
            
            for img in images {
                
                let url = NSURL(string: img)
                let data = NSData(contentsOfURL: url!)
                let image = UIImage(data: data!)
                self.instagramImages.append(image!)
            }
            
            for cap in captions {
                
                self.instagramCaptions.append(cap)
            }
            
            self.tblIGResults.reloadData()
            
        }
    }
    
    func loadPhotos(completion: DownloadComplete) {
        
        let url = NSURL(string: urlBase + accessToken3)
//        print(url!)
        Alamofire.request(.GET, url!).responseJSON { response in
            let result = response.result
            
            var imagesArray = [String]()
            var captionsArray = [String]()
            
            if let r = result.value as? Dictionary<String, AnyObject> {
                
                if let dataArr = r["data"] as? Array<AnyObject> {
                    
                    for item in dataArr {
                        
                        if let i = item as? Dictionary<String, AnyObject> {
                            
                            if let images = i["images"] as? Dictionary<String, AnyObject> {
                                
                                if let standRes = images["standard_resolution"] as? Dictionary<String, AnyObject> {
                                    
                                    if let imgURL = standRes["url"] as? String {
                                        
                                        imagesArray.append(imgURL)
                                    }
                                }
                            }
                            
                            if let cap = i["caption"] as? Dictionary<String, AnyObject> {
                                
                                if let text = cap["text"] as? String {
                                    
                                    captionsArray.append(text)
                                }
                            }
                        }
                    }
                    // loop closes
                }
                
            }
            
            completion(imagesArray, captionsArray)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instagramImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IGCell", forIndexPath: indexPath) as! IGCell
        
        if instagramImages.count > 0 {
            
            cell.imgResultPic.image = instagramImages[indexPath.row]
            cell.lblCaption.text = instagramCaptions[indexPath.row]
            
        } else {
            
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
