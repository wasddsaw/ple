//
//  Webservice.swift
//  PLE
//
//  Created by Lukman Hakim Japri on 04/04/2019.
//  Copyright © 2019 Lukman Hakim Japri. All rights reserved.
//

import UIKit

class Webservice: NSObject {
    
    //var BASIC_URL = "https://www.api.kapetu.com/api/%@"
    var BASIC_URL = "http://u685734502.hostingerapp.com/api/%@"
    
    func requestMessageToken(_ urlString: String?, andData strData: String?, andToken token: String?) -> NSMutableURLRequest? {
        print("requestMessage")
        var headers: [String : String]? = nil
        if let cookies = HTTPCookieStorage.shared.cookies {
            headers = HTTPCookie.requestHeaderFields(with: cookies)
        }
        
        let request = NSMutableURLRequest()
        request.url = URL(string: urlString ?? "")
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Token")
        request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        request.timeoutInterval = 60.0
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    func requestMessage(_ urlString: String?, andData strData: String?) -> NSMutableURLRequest? {
        print("requestMessage")
        var headers: [String : String]? = nil
        if let cookies = HTTPCookieStorage.shared.cookies {
            headers = HTTPCookie.requestHeaderFields(with: cookies)
        }
        
        let request = NSMutableURLRequest()
        request.url = URL(string: urlString ?? "")
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        request.timeoutInterval = 60.0
        request.allHTTPHeaderFields = headers

        return request
    }
    
    func getRequestMessage(_ urlString: String?, andData strData: String?) -> NSMutableURLRequest? {
        print("getRequestMessage")
        var headers: [String : String]? = nil
        if let cookies = HTTPCookieStorage.shared.cookies {
            headers = HTTPCookie.requestHeaderFields(with: cookies)
        }
        
        let request = NSMutableURLRequest()
        request.url = URL(string: urlString ?? "")
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        request.timeoutInterval = 60.0
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    func convertData(_ data: NSDictionary) -> NSString{
        var string = ""
        for key in data {
            string = ("\(string)\(key.key)=\(key.value)&")
        }
        return string as NSString
    }
    
    func userLogin(email: String?,password: String?) -> NSMutableURLRequest? {
        var request: NSMutableURLRequest?
        let data = [
            "email" : email,
            "password": password
        ]
        
        let strData = convertData(data as NSDictionary)
        let urlString = String(format: BASIC_URL,"user/login")
        print("url is \(urlString)")
        
        request = requestMessage(urlString, andData: strData as String)
        return request
    }

}


/*
 
 Qayyum Abg Syakur, [4 Apr 2019 at 11:53:06 PM]:
 //
 //  WebService2.swift
 //  ecom
 //
 //  Created by Abdul Qayyum on 01/04/2019.
 //  Copyright © 2019 Abdul Qayyum. All rights reserved.
 //
 
 import UIKit
 
 class WebService2: NSObject {
 
 var BASIC_URL = "https://www.api.kapetu.com/api/%@"
 
 func requestMessageToken(_ urlString: String?, andData strData: String?, andToken token: String?) -> NSMutableURLRequest? {
 print("requestMessage")
 var headers: [String : String]? = nil
 if let cookies = HTTPCookieStorage.shared.cookies {
 headers = HTTPCookie.requestHeaderFields(with: cookies)
 }
 
 let request = NSMutableURLRequest()
 request.url = URL(string: urlString ?? "")
 request.httpMethod = "POST"
 request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
 request.setValue(token, forHTTPHeaderField: "Token")
 request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
 request.timeoutInterval = 60.0
 request.allHTTPHeaderFields = headers
 
 return request
 }
 
 func requestMessage(_ urlString: String?, andData strData: String?) -> NSMutableURLRequest? {
 print("requestMessage")
 var headers: [String : String]? = nil
 if let cookies = HTTPCookieStorage.shared.cookies {
 headers = HTTPCookie.requestHeaderFields(with: cookies)
 }
 
 let request = NSMutableURLRequest()
 request.url = URL(string: urlString ?? "")
 request.httpMethod = "POST"
 request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
 request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
 request.timeoutInterval = 60.0
 request.allHTTPHeaderFields = headers
 
 //request.setValue("Token", forHTTPHeaderField: "Authorization")
 
 return request
 }
 
 func getRequestMessage(_ urlString: String?, andData strData: String?) -> NSMutableURLRequest? {
 print("getRequestMessage")
 var headers: [String : String]? = nil
 if let cookies = HTTPCookieStorage.shared.cookies {
 headers = HTTPCookie.requestHeaderFields(with: cookies)
 }
 
 let request = NSMutableURLRequest()
 request.url = URL(string: urlString ?? "")
 request.httpMethod = "GET"
 request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
 request.httpBody = strData?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
 request.timeoutInterval = 60.0
 request.allHTTPHeaderFields = headers
 
 return request
 }
 
 func convertData(_ data: NSDictionary) -> NSString{
 var string = ""
 for key in data {
 string = ("\(string)\(key.key)=\(key.value)&")
 }
 return string as NSString
 }
 
 func getArticles() -> NSMutableURLRequest {
 var request :NSMutableURLRequest?
 
 let urlString = String(format: BASIC_URL,"article/all")
 print(urlString)
 
 request = getRequestMessage(urlString, andData: "")
 return request!
 }
 
 func login(email: String?,password: String?) -> NSMutableURLRequest? {
 var request: NSMutableURLRequest?
 let data = [
 "email" : email,
 "password": password
 ]
 
 let strData = convertData(data as NSDictionary)
 let urlString = String(format: BASIC_URL,"user/login")
 print("url is \(urlString)")
 
 request = requestMessage(urlString, andData: strData as String)
 return request
 }
 
 func getPostArticles(token: String?) -> NSMutableURLRequest {
 var request: NSMutableURLRequest?
 
 let urlString = String(format: BASIC_URL,"article/postall")
 print("url is \(urlString)")
 
 request = requestMessageToken
 
 (urlString, andData: "", andToken: token)
 return request!
 }
 
 }
 
 
 
 */
