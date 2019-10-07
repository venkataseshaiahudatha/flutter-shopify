//
//  ForgotPasswordUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class ForgotPasswordUseCase: UseCase {
    
    static let ARG_EMAIL = "email"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
        if let email = args[ForgotPasswordUseCase.ARG_EMAIL],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.resetPassword(with: email) { (success, error) in
                if let successObject = success {
                    result(successObject)
                } else {
                    let errorObject = error
                    self.createError(withCase: "ForgotPasswordUseCase", message: errorObject?.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}

