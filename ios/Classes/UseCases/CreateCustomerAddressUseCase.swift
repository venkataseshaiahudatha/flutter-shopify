//
//  CreateCustomerAddressUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
//import ShopApp_Shopify
//import ShopApp_Gateway
import Flutter

public class CreateCustomerAddressUseCase: UseCase {
    
    static let ARG_ADDRESS_JSON = "addressJson"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        if let addressJson = args[CreateCustomerAddressUseCase.ARG_ADDRESS_JSON],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            let addr = Address(addressJSON: addressJson)
            shopifyAPI.addCustomerAddress(with: addr) { (addressId, error) in
                if let errorObject = error {
                    self.createError(withCase: "CreateCustomerAddressUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                } else {
                    result(addressId)
                }
            }
        }
    }
}
