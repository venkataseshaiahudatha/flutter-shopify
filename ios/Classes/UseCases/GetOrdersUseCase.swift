//
//  GetOrdersUseCase.swift
//  shopify
//
//  Created by Seshu on 10/3/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetOrdersUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage";
    static let ARG_PAGINATION_VALUE = "paginationValue";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        let perPage = args[GetOrdersUseCase.ARG_PER_PAGE]  as? Int  ?? 10
        let paginationValue = args[GetOrdersUseCase.ARG_PAGINATION_VALUE]
        
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getOrderList(perPage: perPage, paginationValue: paginationValue) { [weak self] (orders, error) in
                if let ordersObject: [Order] = orders {
                    let ordersJsonString = ShopApp_Gateway.Category.toDictionaryArray(source: ordersObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: ordersJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetOrdersUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
