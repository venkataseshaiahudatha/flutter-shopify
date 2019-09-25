//
//  GetCountriesUseCase.swift
//  shopify
//
//  Created by Seshu on 9/24/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class GetCountriesUseCase: UseCase {
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        if let shopifyAPI = mContext.api.instance as? ShopifyAPI {
            shopifyAPI.getCountries() { (countries, error) in
                if let countriesObject: [Country] = countries {
                    let customerJsonString = Country.toDictionaryArray(source: countriesObject)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: customerJsonString,  options: .prettyPrinted)
                        let resStr = String.init(data: data, encoding: .utf8) ?? ""
                        result(resStr)
                    } catch {
                        print("Error in converting Object to JSON")
                    }
                } else if let errorObject = error {
                    self.createError(withCase: "GetCountriesUseCase", message: errorObject.errorMessage,
                                     error: errorObject, on: result)
                }
            }
        }
    }
}
