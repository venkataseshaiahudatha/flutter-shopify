//
//  GetAccessTokenUseCase.swift
//  shopify
//
//  Created by Joseph jose on 12/09/19.
//

import UIKit
//import ShopApp_Shopify
//import ShopApp_Gateway
import Flutter

class GetAccessTokenUseCase: UseCase {

    static let ARG_EMAIL = "email"
    static let ARG_PASSWORD = "password"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            
            //TODO: These parameters are not there in Android API and hence this might fail!
            let email = args[GetAccessTokenUseCase.ARG_EMAIL]
            let password = args[GetAccessTokenUseCase.ARG_PASSWORD]
            
            //TODO: This api to get token is private in iOS. not sure what to do!
//            (mContext.api.instance as! ShopifyAPI).
//            (mContext.api.instance as! ShopifyAPI).resetPassword(with: email!) { (success, error) in
//
//                if error != nil {
//
//                    self.createError(withCase: "ForgotPasswordUseCase", message: error!.errorMessage, error: error!, on: result)
//                }else {
//
//                    result(success)
//                }
//            }
        }
    }
}
