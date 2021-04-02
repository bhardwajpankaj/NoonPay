//
//  LoginApi.swift
//  NoonPay//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//



import Foundation

struct Response :Decodable {
    let status : String
    let msg : String
}


class LoginApi : LoginApiProtocol {
    
    var dataTask:URLSessionDataTaskProtocol?
    func get(request: LoginRequestProtocol, completion: @escaping (String? , String?) -> Void) {
        dataTask = RemoteDataSource().responseGet(url: request.apiUrl, completionHandler: { (data,response , error) in
            decodeResponse(data : data , response : response,error : error,responseDto: Response.self){ response in
                completion(response?.status , response?.msg)
            }
        })
    }
    
    func post(request: LoginRequestProtocol, completion: @escaping (String? , String?) -> Void) {
        
        let params = ["phone":request.phoneNo,"password":request.password]
        
        dataTask = RemoteDataSource().postRequest(url: request.apiUrl,parameters:params, completionHandler: { (data,response , error) in
            decodeResponse(data : data , response : response,error : error,responseDto: Response.self){ response in
                completion(response?.status , response?.msg)
            }
        })
    }
    
       
    
    func cancel() {
        self.dataTask?.cancel()
    }
    
    
}

public func decodeResponse<T:Decodable>(data : Data?,response:HTTPURLResponse?,error :Error?,responseDto:T.Type , completion :  (T?) ->Void) {
    guard let httpResponse = response else {
        completion(nil)
        return
    }
    if httpResponse.statusCode == 200 {
        if let data = data {
            do {
                let genericModel = try JSONDecoder().decode(responseDto, from: data)
                completion(genericModel)
            } catch {
                print("Conversion Failure \(error)")
                completion(nil)
            }
        } else {
            print("InvalidData")
            completion(nil)
        }
    } else {
        debugPrint("Response Failure : \(httpResponse)")
        completion(nil)
    }
}
