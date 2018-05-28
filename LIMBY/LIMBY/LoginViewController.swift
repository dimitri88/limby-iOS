//
//  ViewController.swift
//  LIMBY
//
//  Created by Team Memorydust on 2/1/18.
//  Copyright © 2018 Team Memorydust. All rights reserved.
//

import UIKit

var standardError = FileHandle.standardError

extension FileHandle : TextOutputStream {
    public func write(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        self.write(data)
    }
}

class LoginViewController: UIViewController, ParticleSetupMainControllerDelegate {
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
            let email = ParticleCloud.sharedInstance().loggedInUsername
            MongoReader.singleton.getUserId(email: email!)
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
//        if ParticleCloud.sharedInstance().isAuthenticated {
//            eprint(message: "Logged in")
//            let graphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lineChartViewController") as! LineChartViewController
//            self.navigationController?.pushViewController(graphViewController, animated: true)
//        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginParticle(_ sender: UIButton) {
        if let setupController = ParticleSetupMainController(authenticationOnly : true)
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
}



