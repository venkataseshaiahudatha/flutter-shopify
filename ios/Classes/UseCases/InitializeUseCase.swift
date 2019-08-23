//
//  InitializeUseCase.swift
//  shopify
//
//  Created by Joseph jose on 15/08/19.
//

import UIKit
import ShopApp_Shopify

public class InitializeUseCase: UseCase {
    
    static let ARG_BASE_DOMAIN = "baseDomain"
    static let ARG_STORE_FRONT_ACCESS_TOKEN = "storeFrontAccessToken"
    static let ARG_API_KEY = "apiKey"
    static let ARG_API_PASSWORD = "apiPassword"
    
    init(context:PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with call: FlutterMethodCall!, result: FlutterResult!) {
       
        if let args = call.arguments as? [String:String] {
            
            let baseDomain = args[InitializeUseCase.ARG_BASE_DOMAIN]
            let storeFrontAccessToken = args[InitializeUseCase.ARG_STORE_FRONT_ACCESS_TOKEN]
            let apiKey = args[InitializeUseCase.ARG_API_KEY]
            let apiPassword = args[InitializeUseCase.ARG_API_PASSWORD]
            
//            mContext.api.instance = ShopifyAPI(apiKey: <#T##String#>, shopDomain: <#T##String#>, adminApiKey: <#T##String#>, adminPassword: <#T##String#>, applePayMerchantId: <#T##String?#>)
        }
    }
}
