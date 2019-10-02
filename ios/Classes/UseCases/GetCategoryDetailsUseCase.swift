//
//  GetCategoryDetailsUseCase.swift
//  shopify
//
//  Created by Seshu on 10/2/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetCategoryDetailsUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage";
    static let ARG_PAGINATION_VALUE = "paginationValue";
    static let ARG_SORT_BY = "sortBy";
    static let ARG_CATEGORY_ID = "categoryId";
    
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
        let perPage = args[GetCategoryDetailsUseCase.ARG_PER_PAGE]  as? Int  ?? 10
        let paginationValue = args[GetCategoryDetailsUseCase.ARG_PAGINATION_VALUE]
        let sortBy = productSortValue(for: args[GetCategoryDetailsUseCase.ARG_SORT_BY] as? Int)
        let categoryId = args[GetCategoryDetailsUseCase.ARG_CATEGORY_ID] as? String ?? ""
        
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getCategoryDetails(id: categoryId, perPage: perPage, paginationValue: paginationValue, sortBy: sortBy,  reverse: false) { [weak self] (category, error) in
                if let categoryObject = category {
                    do {
                        let data = try categoryObject.toJSONString()
                        result(data)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self!.createError(withCase: "GetCategoryDetailsUseCase", message: errorObject.errorMessage,
                                      error: errorObject, on: result)
                }
            }
        }
    }
}
