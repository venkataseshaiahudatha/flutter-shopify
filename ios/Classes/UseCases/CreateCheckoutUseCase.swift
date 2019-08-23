//
//  CreateCheckoutUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify

class CreateCheckoutUseCase: UseCase {

    static let ARG_CART_PRODUCT_JSON = "cartProductJson"
    
    override init!(_ context: PluginContext!) {
        super.init(context)
    }
    
    override func trigger(with call: FlutterMethodCall!, result: FlutterResult!) {
        
        if let args = call.arguments as? [String:String] {
            let cartProductJson = args[CreateCheckoutUseCase.ARG_CART_PRODUCT_JSON]
            
            
            
//            (mContext.api.instance as! ShopifyAPI).completeCheckout(<#T##checkout: PayCheckout##PayCheckout#>, billingAddress: <#T##PayAddress#>, applePayToken: <#T##String#>, idempotencyToken: <#T##String#>, completion: <#T##(Order?, RepoError?) -> Void#>)
        }
    }
}
