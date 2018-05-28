//
//  MongoReader.swift
//  LIMBY
//
//  Created by Linzuo Li on 5/27/18.
//  Copyright © 2018 Nathan Tsai. All rights reserved.
//
import Foundation
import Alamofire

let user_endpoint = "https://api.mlab.com/api/1/databases/limby/collections/Users?"
let data_endpoint = "https://api.mlab.com/api/1/databases/limby/collections/Data?"
let apiKey = "fhBffZKOPdngmFRwYKsueQfl_WRHg2Z0"
func eprint(message : String) {
    print(message, to: &standardError)
}
class MongoReader {
    
    private var user_id = 0
    static let singleton = MongoReader()
    var queue : [[String: Int]] = []
    private init(){ /* Singletons should be private ctor'd */ }
    
    
    
    enum ParticleError: Error{
        case loginError
        case logicError
    }
    
    func handleErrorAuth(vc : LoginViewController) -> Void{
        eprint(message: "Error!")
    }
    
    func getData() {
        if self.user_id == 0 {
            return
        }
        
        let params: Parameters = [
            "q": [
                "userid": self.user_id
            ],
            "apiKey": apiKey,
            "r": [
                "value": 1,
                "time": 1
            ]
        ]
        
        Alamofire.request(data_endpoint, parameters : params).responseJSON { response in
            if let json = response.result.value as? [[String:Any]]{
                for res in json {
                    let time : Int = res["time"] as! Int
                    let value : Int = res["value"] as! Int
                    let record : [String : Int] = [
                        "time" : time,
                        "value": value
                    ]
                    self.queue.append(record)
                }
            } else{
                eprint(message : "Error, user does not exist in DB")
            }
        }
    }
    
    func getUserId(email : String) {
        let params: Parameters = [
            "q": [
                "email": email
            ],
            "apiKey": apiKey
        ]
        Alamofire.request(user_endpoint,parameters : params).responseJSON { response in
            if let json = response.result.value as? [[String:Any]]{
                for res in json {
                   self.user_id = res["userid"] as! Int
                   print(self.user_id)
                }
            } else{
                eprint(message: "Erro, user does not exist in DB")
            }
        }
    }
    
    func checkExist(deviceName : String) -> Bool {
        var exists : Bool = true
        ParticleCloud.sharedInstance().getDevices { (devices:[ParticleDevice]?, error:Error?) -> Void in
            if let _ = error {
                eprint(message: "Check your internet connectivity")
                exists = false
            }
            else {
                if let d = devices {
                    for device in d {
                        if device.name == deviceName {
                            eprint(message: "Successfully retrieved chicken weigher.")
                        }
                        else {
                            exists = false
                        }
                    }
                }
            }
        }
        return exists
    }
}
