//
//  SearchProductListUseCase.swift
//  shopify
//
//  Created by Seshu on 9/30/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class SearchProductListUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage";
    static let ARG_PAGINATION_VALUE = "paginationValue";
    static let ARG_QUERY = "query";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
 
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        let perPage = args[SearchProductListUseCase.ARG_PER_PAGE]  as? Int ?? 10
        let paginationValue = args[SearchProductListUseCase.ARG_PAGINATION_VALUE]
        let query = args[SearchProductListUseCase.ARG_QUERY] as? String ?? ""
        
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.searchProducts(perPage: perPage, paginationValue: paginationValue, searchQuery: query) { [weak self] (products, error) in
                if let countriesObject: [Product] = products {
                    let customerJsonString = Product.toDictionaryArray(source: countriesObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: customerJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "SearchProductListUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
