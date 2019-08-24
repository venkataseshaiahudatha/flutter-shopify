//
//  ShopifyPlugin.swift
//  shopify
//
//  Created by Joseph jose on 23/08/19.
//

import UIKit
import Flutter

class ShopifyPlugin: Plugin {

    func register(with registrar:FlutterPluginRegistrar) {

        let plugin = ShopifyPlugin(name: "shopify", registrar: registrar, api: Api())
        plugin.description //patch fix
    }

    override func onCreateUseCase(with provider: UseCaseProvider) {

    }
}
