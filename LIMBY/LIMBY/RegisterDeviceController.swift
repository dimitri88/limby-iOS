//
//  RegisterDeviceController.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/16/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//

import UIKit
class RegisterDeviceController: UIViewController, ParticleSetupMainControllerDelegate {
    
    func particleSetupViewController(_ controller: ParticleSetupMainController!, didFinishWith result: ParticleSetupMainControllerResult, device: ParticleDevice!) {
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
    
    @IBAction func SetUpDevice(_ sender: Any) {
        var setupController = ParticleSetupMainController()
        self.present(setupController!, animated: true, completion: nil)
    }
}
