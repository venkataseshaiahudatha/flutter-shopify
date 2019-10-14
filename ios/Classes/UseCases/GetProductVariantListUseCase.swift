//
//  GetProductVariantListUseCase.swift
//  shopify
//
//  Created by Seshu on 9/30/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetProductVariantListUseCase: UseCase {
    
    static let ARG_PRODUCT_VARIANT_IDS = "productVariantIds";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        
        if let productVariantIds:[String] = args[GetProductVariantListUseCase.ARG_PRODUCT_VARIANT_IDS] as? [String],
            let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getProductVariantList(ids: productVariantIds) { [weak self] (productVariants, error) in
                if let productVariantsObject: [ProductVariant] = productVariants {
                    let productVariantsJsonString = ProductVariant.toDictionaryArray(source: productVariantsObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: productVariantsJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetProductVariantListUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
