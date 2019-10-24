//
//  GetShippingRatesUseCase.swift
//  shopify
//
//  Created by Seshu on 10/6/19.
//

import UIKit
//import ShopApp_Shopify
//import ShopApp_Gateway
import Flutter

public class GetShippingRatesUseCase: UseCase {
    
    static let ARG_CHECKOUT_ID = "checkoutId";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        
        if let checkoutId = args[GetShippingRatesUseCase.ARG_CHECKOUT_ID]  as? String,
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getShippingRates(with: checkoutId) { [weak self] (orders, error) in
                if let ordersObject: [ShippingRate] = orders {
                    let ordersJsonString = ShippingRate.toDictionaryArray(source: ordersObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: ordersJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetShippingRatesUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
