//
//  SignUpUseCase.swift
//  shopify
//
//  Created by Seshu on 9/20/19.
//

import Foundation
import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class SignUpUseCase: UseCase {
    
    static let ARG_EMAIL = "email"
    static let ARG_PASSWORD = "password"
    static let ARG_FIRST_NAME = "firstName";
    static let ARG_LAST_NAME = "lastName";
    static let ARG_PHONE = "phone";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
        if let emailValue = args[SignUpUseCase.ARG_EMAIL] ,
            let passwordValue = args[SignUpUseCase.ARG_PASSWORD],
            let firstNameValue = args[SignUpUseCase.ARG_FIRST_NAME],
            let lastNameValue = args[SignUpUseCase.ARG_LAST_NAME],
            let phoneValue = args[SignUpUseCase.ARG_PHONE],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            
            shopifyAPI.signUp(with: emailValue, firstName: firstNameValue, lastName: lastNameValue, password: passwordValue, phone: phoneValue) { (success, error) in
                if let successObject = success {
                    result("success")
                } else {
                    let errorObject = error
                    self.createError(withCase: "SignUpUseCase", message: errorObject?.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
