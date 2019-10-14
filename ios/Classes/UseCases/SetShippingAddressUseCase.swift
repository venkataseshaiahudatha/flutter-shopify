//
//  SetShippingAddressUseCase.swift
//  shopify
//
//  Created by Seshu on 10/6/19.
//

import UIKit
import ShopApp_Gateway
import Flutter

public class SetShippingAddressUseCase: UseCase {
    
    static let ARG_ADDRESS_ID = "addressId"
    static let ARG_PRIMARY_ADDRESS = "primaryAddress"
    static let ARG_SECOND_ADDRESS = "secondAddress"
    static let ARG_CITY = "city"
    static let ARG_STATE = "state"
    static let ARG_COUNTRY = "country"
    static let ARG_ZIP = "zip"
    static let ARG_FIRST_NAME = "firstName"
    static let ARG_LAST_NAME = "lastName"
    static let ARG_COMPANY = "company"
    static let ARG_PHONE = "phone"
    static let ARG_CHECKOUT_ID = "checkoutId";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        let id = args[SetShippingAddressUseCase.ARG_ADDRESS_ID]
        let primaryAddress = args[SetShippingAddressUseCase.ARG_PRIMARY_ADDRESS]
        let secondAddress = args[SetShippingAddressUseCase.ARG_SECOND_ADDRESS]
        let city = args[SetShippingAddressUseCase.ARG_CITY]
        let state = args[SetShippingAddressUseCase.ARG_STATE]
        let country = args[SetShippingAddressUseCase.ARG_COUNTRY]
        let firstName = args[SetShippingAddressUseCase.ARG_FIRST_NAME]
        let lastName = args[SetShippingAddressUseCase.ARG_LAST_NAME]
        let zip = args[SetShippingAddressUseCase.ARG_ZIP]
        let company = args[SetShippingAddressUseCase.ARG_COMPANY]
        let phone = args[SetShippingAddressUseCase.ARG_PHONE]
        let checkoutId = args[SetShippingAddressUseCase.ARG_CHECKOUT_ID] as? String ?? ""
        
        let address = Address()
        address.firstName = firstName
        address.lastName = lastName
        address.address = primaryAddress
        address.secondAddress = secondAddress
        address.city = city
        address.state = state
        address.country = country
        address.zip = zip
        address.phone = phone
        address.id = id ?? ""
        
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.updateShippingAddress(with: checkoutId, address: address) { (success, error) in
                if success ?? false {
                    shopifyAPI.getCheckout(with: checkoutId) { (checkout, error) in
                        if let checkoutObject = checkout {
                                let jsonResponse = checkoutObject.toJSONString()
                                result(jsonResponse)
                        }
                    }
                } else {
                    let errorObject = error
                    self.createError(withCase: "SetShippingAddressUseCase", message: errorObject?.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
        
    }
}
