//
//  UseCase.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit
import Flutter

public class UseCase: NSObject {
    
    var mContext:PluginContext?
    
    init(context:PluginContext) {
        
        super.init()
    }
    
    public func execute(with methodCall:FlutterMethodCall, result:@escaping FlutterResult) {
        
        DispatchQueue.global().async {
            
            self.trigger(with: methodCall, result: result)
        }
    }
    
    public func trigger(with methodCall:FlutterMethodCall, result:@escaping FlutterResult) {
        
        //override
    }
    
    public func createError(with errorCase:String, message:String, error:Any, on result: @escaping FlutterResult) {
        
        let errorString = String("\(errorCase) \(message) \(error)")
        result(errorString)
    }
}
