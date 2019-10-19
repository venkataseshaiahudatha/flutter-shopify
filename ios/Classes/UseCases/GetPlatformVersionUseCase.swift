//
//  GetPlatformVersionUseCase.swift
//  shopify
//
//  Created by Seshu on 10/16/19.
//

import UIKit
import Flutter

public class GetPlatformVersionUseCase: UseCase {
    
    override public init(_ context:PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        let platformVersion = UIDevice.current.systemVersion + " iOS"
        result(platformVersion);
    }
}
