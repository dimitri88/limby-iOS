//
//  RegisterDeviceController.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/16/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//

import UIKit
class RegisterDeviceController: UIViewController, ParticleSetupMainControllerDelegate{
    
    func particleSetupViewController(_ controller: ParticleSetupMainController!, didFinishWith result: ParticleSetupMainControllerResult, device: ParticleDevice!) {
        switch result
        {
        case .success:
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Setup(_ sender: Any) {
        if let setupController = ParticleSetupMainController()
        {
            let customization = ParticleSetupCustomization.sharedInstance
            customization().deviceName = "Perch"
            customization().brandName = "Limby"
            let image = UIImage(named: "bird.jpg")
            let themeColor = UIColor(displayP3Red: 0.063, green: 0.565, blue: 0.741, alpha: 1.0)
            customization().brandImage = image
            customization().elementBackgroundColor = themeColor
            customization().normalTextColor = themeColor
            customization().lightStatusAndNavBar = false
            setupController.delegate = self
            self.present(setupController, animated: true, completion: nil)
        }
    }
    
    
}
