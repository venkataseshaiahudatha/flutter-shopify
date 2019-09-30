//
//  GetCardTokenUseCase.swift
//  shopify
//
//  Created by Joseph jose on 29/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class GetCardTokenUseCase: UseCase {

    static let ARG_CARD_FIRST_NAME = "firstName"
    static let ARG_CARD_LAST_NAME = "lastName";
    static let ARG_CARD_NUMBER = "cardNumber";
    static let ARG_CARD_EXPIRE_MONTH = "expireMonth";
    static let ARG_CARD_EXPIRE_YEAR = "expireYear";
    static let ARG_CARD_VERIFICATION_CODE = "verificationCode";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
//        if let emailValue = args[SignInUseCase.ARG_EMAIL] ,let passwordValue = args[SignInUseCase.ARG_PASSWORD] {
//            
//            
//        }
    }
}
