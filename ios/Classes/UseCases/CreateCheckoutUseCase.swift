//
//  CreateCheckoutUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify
import Flutter

public class CreateCheckoutUseCase: UseCase {

    static let ARG_CART_PRODUCT_JSON = "cartProductJson"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            let cartProductJson = args[CreateCheckoutUseCase.ARG_CART_PRODUCT_JSON]
            
            
            
            //            (mContext.api.instance as! ShopifyAPI).completeCheckout(<#T##checkout: PayCheckout##PayCheckout#>, billingAddress: <#T##PayAddress#>, applePayToken: <#T##String#>, idempotencyToken: <#T##String#>, completion: <#T##(Order?, RepoError?) -> Void#>)
        }
    }
}
