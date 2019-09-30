//
//  GetProductListUseCase.swift
//  shopify
//
//  Created by Seshu on 9/28/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetProductListUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage";
    static let ARG_PAGINATION_VALUE = "paginationValue";
    static let ARG_SORT_BY = "sortBy";
    static let ARG_KEYWORD = "keyword";
    static let ARG_EXCLUDE_KEYWORD = "excludeKeyword";
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    private func productSortValue(for key: Int?) -> SortingValue? {
        if key == nil {
            return SortingValue.name
        }
        switch key! {
        case 1:
            return SortingValue.createdAt
        case 0:
            return SortingValue.name
        case 2:
            return SortingValue.popular
        case 4:
            return SortingValue.type
        case 5:
            return SortingValue.priceHighToLow
        case 6:
            return SortingValue.priceLowToHigh
        default:
            return SortingValue.name
        }
    }
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        guard let args = methodCall.arguments as? [String:Any] else {
            return
        }
        let perPage = args[GetProductListUseCase.ARG_PER_PAGE]  as? Int
        let paginationValue = args[GetProductListUseCase.ARG_PAGINATION_VALUE]
        let sortBy = productSortValue(for: args[GetProductListUseCase.ARG_SORT_BY] as? Int)
        let keyword = args[GetProductListUseCase.ARG_KEYWORD] as? String
        let excludeKeyword = args[GetProductListUseCase.ARG_EXCLUDE_KEYWORD] as? String
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getProductList(perPage: perPage ?? 10, paginationValue: paginationValue, sortBy: sortBy, keyPhrase: keyword, excludePhrase: excludeKeyword, reverse: false) { [weak self] (products, error) in
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
                    self!.createError(withCase: "GetProductListUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
