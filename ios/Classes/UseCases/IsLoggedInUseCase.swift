//
//  IsLoggedInUseCase.swift
//  shopify
//
//  Created by Seshu on 9/21/19.
//

import UIKit
import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class IsLoggedInUseCase: UseCase {
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            let isLoggedIn = shopifyAPI.isLoggedIn()
            result(isLoggedIn)
        }
    }
}
