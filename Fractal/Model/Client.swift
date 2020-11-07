//
//  Client.swift
//  Fractal
//
//  Created by Pedro Cortez on 11/6/20.
//  Copyright © 2020 gamestorming. All rights reserved.
//

import UIKit
import SwiftyJSON

class Client: NSObject {
    var id: String = ""
    var firstName: String = ""
    var lastName = ""
    var phone: String = ""
    var email: String = ""
    
    convenience init(cliId: String, json: JSON){
        self.init()
        
        self.id = cliId
        
        if let firstName = json["firstName"].string{
            self.firstName = firstName
        }
        if let lastName = json["lastName"].string{
            self.lastName = lastName
        }
        if let phone = json["phone"].string{
            self.phone = phone
        }
        if let email = json["email"].string{
            self.email = email
        }
    
    }
    
    func getName() -> String{
        return "\(self.firstName) \(self.lastName)"
    }
    
    
    func userId() -> Int?{
        if let index = self.id.index(of: "c"){
            let id = String(self.id[self.id.index(after: index)...])
            return Int(id)
        }
        
        return nil
    }
}
