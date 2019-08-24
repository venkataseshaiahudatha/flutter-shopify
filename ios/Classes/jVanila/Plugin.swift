//
//  Plugin.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit
import Flutter

public class Plugin: NSObject, FlutterPlugin {

    var mUseCaseProvider:UseCaseProvider
    var mPluginContext:PluginContext
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        //never!
        abort()
    }
    
    public init(name:String, registrar:FlutterPluginRegistrar, api:Api) {
        
        mUseCaseProvider = UseCaseProvider()
        mPluginContext = PluginContext()
        super.init()
        let channel = FlutterMethodChannel(name: name, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: channel)
        
        mPluginContext.api = api
        mPluginContext.plugin = self
        
        self.onCreateUseCase(with: mUseCaseProvider)
    }
    
    public func onCreateUseCase(with provider:UseCaseProvider) {
        
        
    }
    
    public func handleMethod(call:FlutterMethodCall, result:@escaping FlutterResult ) {
        
        let asyncResult = {(res:Any) in
            
            DispatchQueue.main.async {
                
                result(res)
            }
        }
        
        self.mUseCaseProvider.of(clazz: call.method).execute(with: call, result: asyncResult)
    }
    
    func onDestroy() {
        
    }
    
}
