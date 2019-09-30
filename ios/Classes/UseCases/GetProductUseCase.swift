//
//  GetProductUseCase.swift
//  shopify
//
//  Created by Seshu on 9/30/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetProductUseCase: UseCase {
    
    static let ARG_PRODUCT_ID = "productId";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        
        if let productId = args[GetProductUseCase.ARG_PRODUCT_ID] as? String,
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getProduct(id: productId ) { [weak self] (product, error) in
                if let productObject = product {
                    do {
                        let data = try productObject.toJSONString()
                        result(data)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetProductUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
