//
//  GetPlatformVersionUseCase.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit
import Flutter

class GetPlatformVersionUseCase: UseCase {
    
    override func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        result("iOS" + UIDevice.current.systemVersion)
    }

}
