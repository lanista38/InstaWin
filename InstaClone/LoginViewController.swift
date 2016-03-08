//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Jorge Cruz on 3/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var usernameTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextView.text!, password: passwordTextView.text!) { (user: PFUser?, error: NSError?) -> Void in
            if (user != nil)
            {
                print("You are logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameTextView.text
        newUser.password = passwordTextView.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool,  error: NSError?) -> Void in
            if success {
                print("Created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("failed")
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
