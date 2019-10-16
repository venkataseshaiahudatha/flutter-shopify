//
//  ShopifyPlugin.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ShopifyPlugin.h"
#import "Plugin.h"
#import "ClosePluginUseCase.h"
#import "GetPlatformVersionUseCase.h"
#import "shopify/shopify-Swift.h"

@implementation ShopifyPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    ShopifyPlugin *plugin = [[ShopifyPlugin alloc]
                             initWith:@"shopify"
                             withRegistrar:registrar
                             withApi:[[Api alloc] init]];
    [plugin description];//patch fix
}

-(void)onCreateUseCasesWith:(UseCaseProvider *)provider
{
    [provider registerUseCase:@"close"
        with:[[ClosePluginUseCase alloc] initWith:self.mPluginContext]];
    [provider registerUseCase:@"getPlatformVersion"
        with:[[GetPlatformVersionUseCase alloc] initWith:self.mPluginContext]];
    [provider registerUseCase:@"initialize"
                         with:[[InitializeUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"signIn"
                         with:[[SignInUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"signOut"
                         with:[[SignOutUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"signUp"
                         with:[[SignUpUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getCustomer"
                         with:[[GetCustomerUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"isLoggedIn"
                         with:[[IsLoggedInUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"createCustomerAddress"
                         with:[[CreateCustomerAddressUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"editCustomerAddress"
                         with:[[EditCustomerAddressUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"editCustomerInfo"
                         with:[[EditCustomerInfoUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"deleteCustomerAddress"
                         with:[[DeleteCustomerAddressUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"updateCustomerSettings"
                         with:[[UpdateCustomerSettingsUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"changePassword"
                         with:[[ChangePasswordUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"forgotPassword"
                         with:[[ForgotPasswordUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getCountries"
                         with:[[GetCountriesUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getProductList"
                         with:[[GetProductListUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"searchProductList"
                         with:[[SearchProductListUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getProduct"
                         with:[[GetProductUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getProductVariantList"
                         with:[[GetProductVariantListUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getShopInfo"
                         with:[[GetShopInfoUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"createCheckout"
                         with:[[CreateCheckoutUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getCategoryList"
                         with:[[GetCategoryListUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getCategoryDetails"
                         with:[[GetCategoryDetailsUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getOrders"
                         with:[[GetOrdersUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getOrder"
                         with:[[GetOrderUseCase alloc]initWith:self.mPluginContext]];
    [provider registerUseCase:@"getShippingRates"
                         with:[[GetShippingRatesUseCase alloc]initWith:self.mPluginContext]];
    
    [provider registerUseCase:@"setShippingAddress"
                         with:[[SetShippingAddressUseCase alloc]initWith:self.mPluginContext]];
    
    }

@end
