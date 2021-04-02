//
//  LoginVCViewModel.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation
class LoginVCViewModel {
    var type:FieldType?
    var api : LoginApiProtocol!
    let cuntryCodeArray = ["+971","+966","+965"]

    func loginPost(phoneNo: String, password : String , searchApi :LoginApiProtocol = LoginApi(),completionHandler:@escaping(Bool?)->Void){
        if api != nil {
            api.cancel()
        }
        api = searchApi
        let request = LoginApiRequest(phoneNo,password:password)
        api.get(request: request) { (status, msg) in
            completionHandler(true)
        }
    }
}
protocol LoginApiProtocol {
    func get(request : LoginRequestProtocol , completion:@escaping(String? ,String?)->Void)
    func post(request : LoginRequestProtocol , completion:@escaping(String? ,String?)->Void)
    func cancel()
}
