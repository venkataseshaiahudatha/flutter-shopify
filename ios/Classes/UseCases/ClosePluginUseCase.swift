//
//  ClosePluginUseCase.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit
import Flutter

class ClosePluginUseCase: UseCase {
    
    override func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        self.mContext?.plugin.onDestroy()
        result("success")
    }
}
