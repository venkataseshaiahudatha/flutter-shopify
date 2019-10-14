//
//  GetOrderUseCase.swift
//  shopify
//
//  Created by Seshu on 10/6/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetOrderUseCase: UseCase {
    
    static let ARG_ORDER_ID = "orderId";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        
        if let perPage = args[GetOrderUseCase.ARG_ORDER_ID] as? String,
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getOrder(id: perPage ) { [weak self] (order, error) in
                if let orderObject = order {
                    do {
                        let data = try orderObject.toJSONString()
                        result(data)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetOrderUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}

