//
//  BaseRequester.swift
//  AMBaseFoundation
//
//  Created by tom on 2018/5/27.
//

import UIKit
import AFNetworking

public class BaseRequester: NSObject {
    
    public lazy var sessionManager:AFHTTPSessionManager = {
        let sessionManager = AFHTTPSessionManager.init(baseURL: URL.init(string: self.hosts![0]))
        sessionManager.requestSerializer = AFJSONRequestSerializer.init()
        sessionManager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        sessionManager.requestSerializer.timeoutInterval = 15.0
        sessionManager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        sessionManager.responseSerializer = AFHTTPResponseSerializer.init()
        return sessionManager
    }()
    
    public var hosts : Array<String>? {
        get{
            let hostsPath = Bundle.main.path(forResource: "Hosts", ofType: "plist")
            guard (hostsPath != nil) else{
                return nil
            }
            return NSArray.init(contentsOfFile: hostsPath!) as? Array
        }
    }
    
    public func requestTest(a:String,b:String,success:((_ result:Any?)->Void)?,failure:((String,uint,String)->Void)?){
        self.sessionManager.post(a, parameters: nil, progress: nil, success: { (task, response) in
            guard success != nil else{
                return
            }
            success!(response)
        }) { (task, error) in
            failure!("a",1,"b")
        }
    }

}
