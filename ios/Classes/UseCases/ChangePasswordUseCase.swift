//
//  ChangePasswordUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
//import ShopApp_Shopify
import Flutter

public class ChangePasswordUseCase: UseCase {
    
    static let ARG_PASSWORD = "password"
    
    override public init(_ context:PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
        if let password = args[ChangePasswordUseCase.ARG_PASSWORD],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.updateCustomer(with: password ) { (customer, error) in
                if customer != nil {
                    result(true)
                } else if let errorObject = error {
                    self.createError(withCase: "ChangePasswordUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}

