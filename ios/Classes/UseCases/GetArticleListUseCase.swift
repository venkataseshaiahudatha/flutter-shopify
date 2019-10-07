//
//  GetArticleListUseCase.swift
//  shopify
//
//  Created by Joseph jose on 12/09/19.
//

import UIKit
//import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class GetArticleListUseCase: UseCase {
    
    static let ARG_PER_PAGE = "perPage"
    static let ARG_PAGINATION_VALUE = "paginationValue"
    static let ARG_SORT_BY = "sortBy"
    static let ARG_REVERSE = "reverse"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:Any] {

            let perPage = args[GetArticleListUseCase.ARG_PER_PAGE] as? Int ?? 0
            let paginationValue = args[GetArticleListUseCase.ARG_PAGINATION_VALUE] as Any
            let sortBy = args[GetArticleListUseCase.ARG_SORT_BY] as! SortingValue ?? SortingValue.popular
            let reverse = args[GetArticleListUseCase.ARG_REVERSE] as? Bool ?? false
            
            (mContext.api.instance as! ShopifyAPI).getArticleList(perPage: perPage  , paginationValue: paginationValue, sortBy: sortBy, reverse: reverse) { (articles, error) in
                
                if articles != nil {
                    if articles!.count > 0 {
                        var articleJSONArray = [[String : AnyObject]]()
                        for article in articles! {
                            
                            let articleJSON = article.toDictionary()
                            articleJSONArray.append(articleJSON)
                        }
                        do {
                            let articleListJSONData = try JSONSerialization.data(withJSONObject: articleJSONArray, options: .prettyPrinted)
                            let articlesJsonString = String(data: articleListJSONData, encoding: .utf8)
                            result(articlesJsonString)
                            return
                        }
                        catch {
                            
                            self.createError(withCase: "GetArticleListUseCaseError", message: error.localizedDescription,
                                             error: error, on: result)
                            return
                        }
                    }
                    self.createError(withCase: "GetArticleListUseCaseError", message: error?.errorMessage,
                                     error: error, on: result)
                    return
                }
                self.createError(withCase: "GetArticleListUseCaseError", message: error?.errorMessage,
                                 error: error, on: result)
                return
            }
        }
    }
}
