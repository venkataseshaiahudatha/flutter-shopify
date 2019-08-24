//
//  ChangePasswordUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify
import Flutter

class ChangePasswordUseCase: UseCase {
    
    static let ARG_PASSWORD = "password"
    
    override init(_ context:PluginContext) {
        super.init(context)
    }
    
    override func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            
            if let password = args[ChangePasswordUseCase.ARG_PASSWORD] {
                
                //                (mContext?.api.instance as! ShopifyAPI).resetPassword(with: password) { (success, error) in
                //
                //                    if error != nil {
                //
                //                        self.createError(with: "ChangePasswordUseCase", message: error!.errorMessage ?? "", error: error!, on: result)
                //
                //                    }else {
                //                        if success != nil {
                //
                //                            result(true)
                //                        }
                //                    }
                //                }
            }
        }
    }
}
