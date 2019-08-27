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
                    
                    checkoutObj.shippingLine = createShippingRateObject(from: _shippingLine)
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
                            if let _sr = createShippingRateObject(from: jsonString) {
                                if _availableShippingRates == nil {
                                    
                                    _availableShippingRates = [ShippingRate]()
                                }
                                _availableShippingRates?.append(_sr)
                            }
                        }
                    }
                    checkoutObj.availableShippingRates = _availableShippingRates
                }
                if let _dataString = checkoutJSON["lineItems"] {
                    if let lineItemsArray = try JSONSerialization.jsonObject(with: _dataString.data(using: .utf8)!, options: .allowFragments) as? [Dictionary<String, String>] {
                        
                        for li in lineItemsArray {
                            
                            let liJSON = try JSONSerialization.data(withJSONObject: li, options: .prettyPrinted)
                            let jsonString = String(data: liJSON, encoding: .utf8)!
                            if let _li = createLineItemObject(from: jsonString) {
                                _lineItems.append(_li)
                            }
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
    
    func createShippingRateObject(from shippngRate:String?) -> ShippingRate? {
        
        guard shippngRate != nil else {
            return nil
        }
        let shippingRateObj = ShippingRate()
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: shippngRate!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                shippingRateObj.title = addressJSONDict["title"]
                shippingRateObj.price = addressJSONDict["price"]
                shippingRateObj.handle = addressJSONDict["handle"]!
                return shippingRateObj
            }
            
            return nil
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
            return nil
        }
    }
    
    func createLineItemObject(from lineItem:String?) -> LineItem? {
        
        guard lineItem != nil else {
            return nil
        }
        let lineItemObj = LineItem()
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: lineItem!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, Any> {
                
                lineItemObj.id = addressJSONDict["id"] as! String
                if let temp = addressJSONDict["price"] as? Int {
                    
                    lineItemObj.price = Decimal(integerLiteral: temp)
                }
                lineItemObj.quantity = addressJSONDict["quantity"] as? Int ?? 0
                return lineItemObj
            }
            
            return nil
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
            return nil
        }
    }
    
    
}
