//
//  LoginRequestProtocol.swift
//  NoonPay//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation

protocol LoginRequestProtocol {
    var apiUrl: String {get}
    var phoneNo : String {get}
    var password : String {get}
    init(_ phoneNo:String,password:String)
}
