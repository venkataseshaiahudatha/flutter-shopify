//
//  GetCategoryListUseCase.swift
//  shopify
//
//  Created by Seshu on 10/2/19.
//

import UIKit
//import ShopApp_Shopify
//import ShopApp_Gateway
import Flutter

public class GetCategoryListUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage";
    static let ARG_PAGINATION_VALUE = "paginationValue";
    
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
        let perPage = args[GetProductListUseCase.ARG_PER_PAGE]  as? Int  ?? 10
        let paginationValue = args[GetProductListUseCase.ARG_PAGINATION_VALUE]
        let sortBy = productSortValue(for: 0)


        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getCategoryList(perPage: perPage, paginationValue: paginationValue, sortBy: sortBy,  reverse: false) { [weak self] (categories, error) in
                if let categoriesObject: [Category] = categories {
                    let categoriesJsonString = Category.toDictionaryArray(source: categoriesObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: categoriesJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetCategoryListUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}

