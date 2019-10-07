//
//  GetCustomerUseCase.swift
//  shopify
//
//  Created by Seshu on 9/21/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetCustomerUseCase: UseCase {
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getCustomer() { (customer, error) in
                if let customerObject = customer {
                    let customerJsonString = customerObject.toJSONString()
                    result(customerJsonString)
                } else if let errorObject = error {
                    self.createError(withCase: "GetCustomerUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}

