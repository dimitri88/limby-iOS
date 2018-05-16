//
//  RegisterDeviceController.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/16/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//

import UIKit
import sp
class RegisterDeviceController: UIViewController {
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
}
