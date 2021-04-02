//
//  RemoteDataSource.swift
//  NoonPay//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func  dataTask(with url: URL, onCompletion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}
extension URLSession : URLSessionProtocol {
    func dataTask(with url:URL, onCompletion:@escaping(Data?,HTTPURLResponse?,Error?)->Void) -> URLSessionDataTaskProtocol{
        return dataTask(with: url) { (data, response, error) in
            onCompletion(data,response as? HTTPURLResponse , error)
        }
    }
}
extension URLSessionDataTask : URLSessionDataTaskProtocol {
    
}
protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}
class RemoteDataSource {
    
    func responseGet(url:String,session:URLSessionProtocol = URLSession.shared,completionHandler:@escaping(Data?,HTTPURLResponse?,Error?)->Void) -> URLSessionDataTaskProtocol?{
        guard let url = URL(string: url) else{
            return nil
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            completionHandler(data,response,error)
        }
        task.resume()
        return task
    }
    
    func postRequest(url:String, parameters:[String:Any],session:URLSessionProtocol = URLSession.shared,completionHandler:@escaping(Data?,HTTPURLResponse?,Error?)->Void) -> URLSessionDataTaskProtocol?{
            let header = ["Content-Type": "application/json","cache-control": "no-cache",]
            guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return nil
            }
  
            guard let url = URL(string: url) else{
                return nil
            }
            let request = NSMutableURLRequest(url: url as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = header
            request.httpBody = postData as Data
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                completionHandler(data,response as? HTTPURLResponse,error)
            })
            dataTask.resume()
            return dataTask
        }
        
    
}
