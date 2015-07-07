//
//  APIManager.swift
//  Whats Beef
//
//  Created by iOS applicant on 7/07/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

import UIKit

class APIManager: AFHTTPSessionManager  {
    
    class var sharedManager: APIManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: APIManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = APIManager(baseURL: NSURL(string: "http://www.whatsbeef.net"), sessionConfiguration: nil)
        }
        return Static.instance!
    }
}
