//
//  UseCase.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UseCase.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation UseCase

-(id)initWith:(PluginContext *)context
{
    self = [super init];
    if (self)
    {
        _mContext = context;
    }
    return self;
}

-(void)executeWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self triggerWithMethodCall:call result:result];
    });
}

- (void)triggerWithMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    //override
}

- (void)createErrorWithCase:(NSString *)errorCase message:(NSString*)errorMessage error:(NSError*) errorObj on:(FlutterResult)result  {
    
    FlutterError *fError = [FlutterError errorWithCode:errorCase message:errorMessage details:errorObj.localizedDescription];
    result(fError);
}

@end
