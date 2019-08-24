//
//  UseCaseProvider.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit

public class UseCaseProvider: NSObject {

    var mRegistry:NSMutableDictionary
    
    public override init() {
        
        mRegistry = NSMutableDictionary()
        super.init()
    }
    
    public func register(useCase clazz:String, usecase:UseCase) {
        
        mRegistry[clazz] = usecase
    }
    
    public func of(clazz:String) -> UseCase {
        
        return mRegistry.value(forKey: clazz) as! UseCase
    }
}
