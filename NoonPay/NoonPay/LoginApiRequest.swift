//
//  LoginApiRequest.swift
//  NoonPay//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation

struct LoginApiRequest:LoginRequestProtocol{
    var phoneNo : String
    var password : String
    let loginURL  = "https://run.mocky.io/v3/7e379f7d-fd47-4c0b-8d27-e4aea441daad"
    
    init(_ phoneNo:String,password:String) {
        self.phoneNo = phoneNo
        self.password = password
    }
    
    var apiUrl: String {
        return loginURL
    }
}
