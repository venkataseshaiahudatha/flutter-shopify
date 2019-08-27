//
//  CompleteCheckoutByCardUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import MobileBuySDK
import Flutter

public class CompleteCheckoutByCardUseCase: UseCase {
    
    static let ARG_ADDRESS_JSON = "addressJson"
    static let ARG_CHECKOUT_JSON = "checkoutJson"
    static let ARG_CREDIT_CARD_VALUE_TOKEN = "creditCardValueToken"
    static let ARG_EMAIL = "email"
    
    override public init(_ context: PluginContext) {
        
        super.init(context)
    }

    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            let token = args[CompleteCheckoutByCardUseCase.ARG_CREDIT_CARD_VALUE_TOKEN]
            let email = args[CompleteCheckoutByCardUseCase.ARG_EMAIL]
            let addressJson = args[CompleteCheckoutByCardUseCase.ARG_ADDRESS_JSON]
            let checkoutJson = args[CompleteCheckoutByCardUseCase.ARG_CHECKOUT_JSON]
            

            let address = Utilities.shared.createAddressObject(from: addressJson)
            let checkout = Utilities.shared.createCheckoutObject(from: checkoutJson)
            
            
//            (mContext?.api.instance as! ShopifyAPI).completeCheckout(checkout.payCheckout, billingAddress: address as! PayAddress, applePayToken: "", idempotencyToken: token!) { (order, error) in
//                
//                if error != nil {
//                    
//                    result(error!)
//                }else {
//                    
//                    
//                }
//            }
        }
    }
}
