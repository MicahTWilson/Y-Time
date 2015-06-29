//
//  ViewController.swift
//  Y Time
//
//  Created by Micah Wilson on 6/24/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var weeklyTimeLabel: UILabel!
    @IBOutlet weak var periodTimeLabel: UILabel!
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var loginScreen: LoginView?
    var webView: UIWebView?
    var previousURL: String?
    var currentUser: NSManagedObject?
    var username = ""
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let request = NSFetchRequest(entityName: "User")
        do {
            try
            self.currentUser = (self.context.executeFetchRequest(request) as! [NSManagedObject]).first
        }
        catch  _ as NSError {
            print("Failed Fetching user")
        }
        
        if let user = self.currentUser {
            self.username = user.valueForKey("username")! as! String
            self.password = user.valueForKey("password")! as! String
            self.loadLoginBYU()
            return
        } else {
            self.loginScreen = LoginView(frame: self.view.frame)
            self.loginScreen?.loginButton.addTarget(self, action: "submitLoginForm:", forControlEvents: .TouchUpInside)
            self.view.addSubview(self.loginScreen!)
            self.loginScreen?.usernameField.becomeFirstResponder()
        }
    }
    
    func submitLoginForm(sender: UIButton) {
        print("Log in pressed", appendNewline: false)
        self.loginPressed(sender)
    }
    
    func loginPressed(sender: UIButton) {
        self.spinYLogo()
        self.loginScreen?.loginButton.enabled = false
        self.loginScreen?.loginButton.alpha = 0.0
        self.username = self.loginScreen!.usernameField.text!
        self.password = self.loginScreen!.passwordField.text!
        self.loadLoginBYU()
    }
    
    func loadLoginBYU() {
        self.previousURL = nil
        self.webView = UIWebView(frame: CGRectZero)
        self.webView!.delegate = self
        self.webView!.loadRequest(NSURLRequest(URL: NSURL(string: "https://hrms.byu.edu/psc/ps/EMPLOYEE/HRMS/c/Y_EMPLOYEE_SELF_SERVICE.Y_TL_TIME_ENTRY.GBL")!))
    }
    
    func spinYLogo() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_2_PI * 10 * 5))
        rotationAnimation.duration = 5.0
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 5
        self.loginScreen?.logoImageView.layer.addAnimation(rotationAnimation, forKey: "spinner")
    }
    
    func giveErrorMessageForLogin() {
        self.loginScreen?.logoImageView.layer.removeAllAnimations()
        self.loginScreen?.usernameField.textColor = .redColor()
        self.loginScreen?.passwordField.textColor = .redColor()
        self.loginScreen?.loginButton.enabled = true
        self.loginScreen?.loginButton.alpha = 1.0
    }
    
    func loginSuccessful() {
        if currentUser == nil {
            let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.context)
            user.setValue(loginScreen!.usernameField.text!, forKey: "username")
            user.setValue(loginScreen!.passwordField.text!, forKey: "password")
            do {
                try
                self.context.save()
            }
            catch  _ as NSError {
                print("Failed saving new user")
            }
        }
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.loginScreen?.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
        }) { (finished) -> Void in
            self.loginScreen?.removeFromSuperview()
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(webView: UIWebView) {
        //Show some sort of spinner.
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        print(webView.request?.URL?.path, appendNewline: false)
        if let wrongURL = self.previousURL {
            if wrongURL == webView.request?.URL?.path {
                print("information incorrect", appendNewline: false)
                webView.stopLoading()
                self.giveErrorMessageForLogin()
                return
            }
        }
    
        if webView.request?.URL?.path == "/psc/ps/EMPLOYEE/HRMS/c/Y_EMPLOYEE_SELF_SERVICE.Y_TL_TIME_ENTRY.GBL" {
            //Login was successful
            let weeklyJS = "document.getElementById('Y_TL_WRK_Y_TL_W_TOTAL_M').value"
            let periodJS = "document.getElementById('Y_TL_WRK_Y_TL_P_TOTAL_M').value"
            let jobTitleJS = "document.getElementsByClassName('PSHYPERLINK')[3].innerHTML"
            let weeklyHoursValue = webView.stringByEvaluatingJavaScriptFromString(weeklyJS)
            let periodHoursValue = webView.stringByEvaluatingJavaScriptFromString(periodJS)
            self.weeklyTimeLabel.text = weeklyHoursValue
            self.periodTimeLabel.text = periodHoursValue
            self.navBar.topItem?.title = webView.stringByEvaluatingJavaScriptFromString(jobTitleJS)!
            self.loginSuccessful()
            return
        }
        
        if (username.characters.count != 0 && password.characters.count != 0) {
            let usernameJS = "document.getElementById('netid').value = '\(username)'"
            let passwordJS = "document.getElementById('password').value = '\(password)'"
            let submitJS = "document.getElementsByClassName('submit')[0].click()"
            webView.stringByEvaluatingJavaScriptFromString(usernameJS)
            webView.stringByEvaluatingJavaScriptFromString(passwordJS)
            webView.stringByEvaluatingJavaScriptFromString(submitJS)
            
        }
        self.previousURL = webView.request?.URL?.path
    }
    
    @IBAction func reloadData(sender: AnyObject) {
        self.webView?.reload()
    }

}

