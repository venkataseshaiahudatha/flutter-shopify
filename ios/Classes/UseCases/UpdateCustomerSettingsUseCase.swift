//
//  UpdateCustomerSettingsUseCase.swift
//  shopify
//
//  Created by Seshu on 9/22/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class UpdateCustomerSettingsUseCase: UseCase {
    
    private static let ARG_IS_ACCEPT_MARKETING = "isAcceptMarketing";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        
        if let promoValue = args[UpdateCustomerSettingsUseCase.ARG_IS_ACCEPT_MARKETING] as? Bool,
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.updateCustomer(with:promoValue) { (customer, error) in
                if customer != nil {
                    result(true)
                } else if let errorObject = error {
                    self.createError(withCase: "UpdateCustomerSettingsUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
