//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Jorge Cruz on 3/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var photo: UIImage = UIImage()
    
    var data = [PFObject]?()
    var count = 5
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        queryPosts() { (images, error) -> () in
            self.data = images
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
      @IBAction func onSignOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
        print("User logged Out")
    }

    //Table View properties
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data?.count>0 {
            return (data?.count)!
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        let image = self.data?[indexPath.row]
        
        if image != nil
        {
            cell.captionOnCell.text = image!["caption"] as? String
            cell.authorOnCell.text = image!["author"] as? String
            image!["media"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.ImageOnCell.image = image
                }
            }
        }
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        count++
        tableView.reloadData()
    }
    
    func queryPosts(completion: (posts: [PFObject]?, error: NSError?)-> Void){
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                completion(posts: posts, error: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    

}
