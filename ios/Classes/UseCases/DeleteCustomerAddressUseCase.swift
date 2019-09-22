//
//  DeleteCustomerAddressUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class DeleteCustomerAddressUseCase: UseCase {
    
    static let ARG_ADDRESS_ID = "addressId"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
        if let addressId = args[DeleteCustomerAddressUseCase.ARG_ADDRESS_ID],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.deleteCustomerAddress(with: addressId) { (success, error) in
                if let successObject = success {
                    result(successObject)
                } else {
                    let errorObject = error
                    self.createError(withCase: "EditCustomerAddressUseCase", message: errorObject?.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
