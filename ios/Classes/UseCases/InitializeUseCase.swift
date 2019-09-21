//
//  InitializeUseCase.swift
//  shopify
//
//  Created by Joseph jose on 15/08/19.
//

import UIKit
import ShopApp_Shopify
import Flutter

public class InitializeUseCase: UseCase {
    
    static let ARG_BASE_DOMAIN = "baseDomain"
    static let ARG_STORE_FRONT_ACCESS_TOKEN = "storeFrontAccessToken"
    static let ARG_API_KEY = "apiKey"
    static let ARG_API_PASSWORD = "apiPassword"
    
    override public init(_ context:PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        
        guard let args = methodCall.arguments as? [String:String] else {
            return
        }
        if let baseDomain = args[InitializeUseCase.ARG_BASE_DOMAIN] ,
            let storeFrontAccessToken = args[InitializeUseCase.ARG_STORE_FRONT_ACCESS_TOKEN],
            let apiKey = args[InitializeUseCase.ARG_API_KEY],
            let apiPassword = args[InitializeUseCase.ARG_API_PASSWORD]{
            
            mContext?.api.instance = ShopifyAPI(apiKey: storeFrontAccessToken, shopDomain: baseDomain, adminApiKey: apiKey, adminPassword: apiPassword, applePayMerchantId: "APPLE PAY MERCHANT ID")
            let status = "mApi initialized " + String(describing: mContext.api.instance)
            print(status)
            result(status)
        }
    }
}
