//
//  EditCustomerInfoUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class EditCustomerInfoUseCase: UseCase {
    
    static let ARG_FIRST_NAME = "firstName"
    static let ARG_LAST_NAME = "lastName"
    static let ARG_PHONE = "phone"
    static let ARG_EMAIL = "email"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        
        if let firstName = args[EditCustomerInfoUseCase.ARG_FIRST_NAME],
            let lastName = args[EditCustomerInfoUseCase.ARG_LAST_NAME],
            let email = args[EditCustomerInfoUseCase.ARG_EMAIL],
            let phone = args[EditCustomerInfoUseCase.ARG_PHONE],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            
            shopifyAPI.updateCustomer(with: email, firstName: firstName, lastName: lastName, phone: phone) { (customer, error) in
                if let customerObject = customer {
                    let customerJsonString = customerObject.toJSONString()
                    result(customerJsonString)
                } else if let errorObject = error {
                    self.createError(withCase: "EditCustomerInfoUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
