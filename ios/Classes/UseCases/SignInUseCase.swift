//
//  SignInUseCase.swift
//  shopify
//
//  Created by Seshu on 9/19/19.
//

import Foundation
import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class SignInUseCase: UseCase {
    
    static let ARG_EMAIL = "email"
    static let ARG_PASSWORD = "password"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        if let emailValue = args[SignInUseCase.ARG_EMAIL] ,let passwordValue = args[SignInUseCase.ARG_PASSWORD] {
            (mContext.api.instance as! ShopifyAPI).login(with: emailValue, password: passwordValue) { (success, error) in
                if let errorObject = error {
                    self.createError(withCase: "SignInUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                } else {
                    print(success)
                    result(success)
                }
            }
        }
    }
}
