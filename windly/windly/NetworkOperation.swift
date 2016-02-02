//
//  networkOperation.swift
//  stormy
//
//  Created by Kyle Ong on 1/24/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

//start a newtork connection and download the JSON
import Foundation

class NetworkOperation{
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        let request = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request){(let data, let response, let error) in
            //check HTTP response for succesful GET Request
            
            if let httpResponse = response as? NSHTTPURLResponse{
                switch (httpResponse.statusCode){
                case 200: //create JSON object
                    do{
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:[])
                        as! [String: AnyObject]
                        completion(jsonDictionary)
                    }catch let error {
                        print ("JSON Serialization Failed. Error: \(error)")
                    }
                default:
                    print("GET Request not succesful. HTTP Status Code: \(httpResponse.statusCode)")
                }
                
            }else {
                print ("Not a valid HTTP Response")
            }
            
            //create JSON object with data
        
        }
        dataTask.resume()
    }
}