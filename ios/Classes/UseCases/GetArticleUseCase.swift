//
//  GetArticleUseCase.swift
//  shopify
//
//  Created by Joseph jose on 29/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter


class GetArticleUseCase: UseCase {

    static let ARG_ARTICLE_ID = "articleId"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:Any] {
            
            if let articleId = args[GetArticleUseCase.ARG_ARTICLE_ID] as? String {
                
                (mContext.api.instance as! ShopifyAPI).getArticle(id: articleId) { (arg0, error) in
                    
                    
                    if let (article, _) = arg0 {
                        
                        do {
                            let articleJSONData = try JSONSerialization.data(withJSONObject: article.toDictionary(), options: .prettyPrinted)
                            let articleJsonString = String(data: articleJSONData, encoding: .utf8)
                            result(articleJsonString)
                            return
                        }
                        catch {
                            
                            self.createError(withCase: "GetArticleUseCaseError", message: error.localizedDescription,
                                             error: error, on: result)
                            return
                        }
                    }else {
                        
                        self.createError(withCase: "GetArticleUseCaseError", message: error?.errorMessage,
                                         error: error, on: result)
                    }
                }
            }
        }
    }
}
