//
//  GetShopInfoUseCase.swift
//  shopify
//
//  Created by Seshu on 10/1/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetShopInfoUseCase: UseCase {
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getShopInfo() { [weak self] (shop, error) in
                if let shopObject = shop {
                    let data = shopObject.toJSONString()
                    result(data)
                } else if let errorObject = error {
                    self?.createError(withCase: "GetShopInfoUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
