//
//  postViewController.swift
//  InstaClone
//
//  Created by Jorge Cruz on 3/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit

class postViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var toPostImageView: UIImageView!
    @IBOutlet weak var toPostCaption: UITextField!
    var toPostImage = UIImage()
     let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toPostImageView.image = toPostImage
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFinalPost(sender: AnyObject) {
        
        let image = resize(toPostImageView.image!, newSize: CGSizeMake(200,200))
        Post.postUserImage(image, withCaption: toPostCaption.text, withCompletion: nil)
        print("Photo Uploaded")
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onPickPhoto(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        //imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let theImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage !!!
        
        toPostImage = theImage
        toPostImageView.image = toPostImage
        dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}
