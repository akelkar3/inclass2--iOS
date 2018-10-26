//
//  Profile.swift
//  inclass2
//
//  Created by Ankit Kelkar on 10/25/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import Foundation

class Profile: NSObject {
    var name,emailid,password, department :String
    
    init(name: String, password: String, email: String, department: String) {
        self.name = name
        self.password = password
        self.emailid = email
        self.department = department
    }
}
