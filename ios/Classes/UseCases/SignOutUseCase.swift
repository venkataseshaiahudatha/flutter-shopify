//
//  SignOutUseCase.swift
//  shopify
//
//  Created by Seshu on 9/20/19.
//

import Foundation
import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class SignOutUseCase: UseCase {
    
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.logout() { (success, error) in
                if let successObject = success {
                    result(successObject)
                } else {
                    let errorObject = error
                    self.createError(withCase: "SignOutUseCase", message: errorObject?.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
