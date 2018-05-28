//
//  SplashScreenViewController.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/24/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        let email = ParticleCloud.sharedInstance().loggedInUsername
        MongoReader.singleton.getUserId(email: email!)
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeAPICall()
    }
    private func makeAPICall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.activityIndicator.stopAnimating()
            if ParticleCloud.sharedInstance().isAuthenticated {
                eprint(message: "Logged in")
                MongoReader.singleton.getData()
                let graphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController")
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.window?.rootViewController = graphViewController
            } else{
                
                let graphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.window?.rootViewController = graphViewController
            }
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
