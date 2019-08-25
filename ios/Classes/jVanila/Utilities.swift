//
//  Utilities.swift
//  shopify
//
//  Created by Joseph jose on 25/08/19.
//

import UIKit
import ShopApp_Gateway

class Utilities: NSObject {

    static let shared = Utilities()
    
    private override init() {
        
        //so that no one else inits this class
    }
    
    func createAddressObject(from addressJSON:String?) -> Address? {

        guard addressJSON != nil else {
            return nil
        }
        let addressObj = Address()
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: addressJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {

                addressObj.firstName = addressJSONDict["firstName"]
                addressObj.lastName = addressJSONDict["lastName"]
                addressObj.address = addressJSONDict["address"]
                addressObj.secondAddress = addressJSONDict["secondAddress"]
                addressObj.city = addressJSONDict["city"]
                addressObj.country = addressJSONDict["country"]
                addressObj.state = addressJSONDict["state"]
                addressObj.zip = addressJSONDict["zip"]
                addressObj.phone = addressJSONDict["phone"]
                
                return addressObj
            }
            
            return nil
        }
        catch {

            print("Error in converting address JSON string to a valid JSON object!")
            return nil
        }
    }
    
    func createCheckoutObject(from checkout:String?) -> Checkout? {
        
        guard checkout != nil else {
            return nil
        }
        let checkoutObj = Checkout()
        do {
            if let checkoutJSON = try JSONSerialization.jsonObject(with: checkout!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                checkoutObj.id = checkoutJSON["id"]!
                checkoutObj.webUrl = checkoutJSON["webUrl"]!
                if let _subtotalPrice = checkoutJSON["subtotalPrice"] {
                    
                    checkoutObj.subtotalPrice = Decimal(string:_subtotalPrice)
                }
                if let _totalPrice = checkoutJSON["totalPrice"] {
                    
                    checkoutObj.totalPrice = Decimal(string:_totalPrice)
                }
                checkoutObj.currencyCode = checkoutJSON["currencyCode"]
                if let _shippingLine = checkoutJSON["shippingLine"] {
                    
                    checkoutObj.shippingLine = ShippingRate(shippingRate: _shippingLine)
                }
                if let _shippingAddress = checkoutJSON["shippingAddress"] {
                    
                    checkoutObj.shippingAddress = createAddressObject(from: _shippingAddress)!
                }
                var _availableShippingRates:[ShippingRate]?
                var _lineItems = [LineItem]()
                
                
                if let _dataString = checkoutJSON["availableShippingRates"] {
                    if let _availableShippingRatesArray = try JSONSerialization.jsonObject(with: _dataString.data(using: .utf8)!, options: .allowFragments) as? [Dictionary<String, String>] {
                        
                        for asr in _availableShippingRatesArray {
                            
                            let srJSON = try JSONSerialization.data(withJSONObject: asr, options: .prettyPrinted)
                            let jsonString = String(data: srJSON, encoding: .utf8)!
                            let _sr = ShippingRate(shippingRate: jsonString)
                            if _availableShippingRates == nil {
                                
                                _availableShippingRates = [ShippingRate]()
                            }
                            _availableShippingRates?.append(_sr)
                        }
                    }
                    checkoutObj.availableShippingRates = _availableShippingRates
                }
                if let _dataString = checkoutJSON["lineItems"] {
                    if let lineItemsArray = try JSONSerialization.jsonObject(with: _dataString.data(using: .utf8)!, options: .allowFragments) as? [Dictionary<String, String>] {
                        
                        for li in lineItemsArray {
                            
                            let liJSON = try JSONSerialization.data(withJSONObject: li, options: .prettyPrinted)
                            let jsonString = String(data: liJSON, encoding: .utf8)!
                            let _li = LineItem(lineItem: jsonString)
                            _lineItems.append(_li)
                        }
                    }
                    checkoutObj.lineItems = _lineItems
                }
            
            return checkoutObj
                
            }
            return nil
        }
        catch {
            
            print("Error in converting Checkout JSON string to a valid JSON object!")
            return nil
        }
    }
}
