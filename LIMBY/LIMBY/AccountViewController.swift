//
//  AccountViewController.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/23/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, ParticleSetupMainControllerDelegate {
    func particleSetupViewController(_ controller: ParticleSetupMainController!, didFinishWith result: ParticleSetupMainControllerResult, device: ParticleDevice!) {
        switch result
        {
        case .success:
            dismiss(animated: true, completion: nil)
            print("Setup completed successfully")
        case .failureConfigure:
            fallthrough
        case .failureCannotDisconnectFromDevice:
            fallthrough
        case .failureLostConnectionToDevice:
            fallthrough
        case .failureClaiming:
            print("Setup failed")
        case .userCancel :
            print("User cancelled setup")
        case .loggedIn :
            print("User is logged in")
            let graphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController")
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.window?.rootViewController = graphViewController
        default:
            print("Uknown setup error")
            
        }
        
        if device != nil
        {
            device.getVariable("test", completion: { (value, err) -> Void in
                
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.layer.borderWidth = 1.0
        getDevices()
        // Do any additional setup after loading the view.
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
    
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func logout(_ sender: UIButton) {
        ParticleCloud.sharedInstance().logout()
        let graphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = graphViewController
    }
    
    @IBAction func addPerchDevice(_ sender: UIButton) {
        if let setupController = ParticleSetupMainController()
        {
            let customization = ParticleSetupCustomization.sharedInstance
            customization().deviceName = "Perch"
            customization().brandName = "Limby"
            let themeColor = UIColor(displayP3Red: 0.063, green: 0.565, blue: 0.741, alpha: 1.0)
            customization().brandImage = nil
            customization().elementBackgroundColor = themeColor
            customization().brandImageBackgroundColor = themeColor
            customization().normalTextColor = themeColor
            setupController.delegate = self
            self.present(setupController, animated: true, completion: nil)
        }

    }
    
    func getDevices(){
        var myPhoton : ParticleDevice?
        ParticleCloud.sharedInstance().getDevices { (devices:[ParticleDevice]?, error:Error?) -> Void in
            if let _ = error {
                print("Check your internet connectivity")
            }
            else {
                if let d = devices {
                    for device in d {
                        if device.name == "myNewPhotonName" {
                            myPhoton = device
                        }
                    }
                }
            }
        }
    }
}
