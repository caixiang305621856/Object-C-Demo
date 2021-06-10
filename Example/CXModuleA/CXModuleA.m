//
//  CXModuleA.m
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import "CXModuleA.h"
#import "CXModuleAProtocol.h"
#import "CXComponentManager.h"
#import "CXModuleADetailViewController.h"

@interface CXModuleA ()<CXModuleAProtocol>
@property (weak, nonatomic) CXModuleADetailViewController *moduleADetailViewController;

@end

@implementation CXModuleA
+ (void)initialize {
    [super initialize];
    [CXComponentManager registerConnector:@protocol(CXModuleAProtocol)];
}

- (BOOL)canOpenURL:(nonnull NSURL *)URL {
    if ([URL.host isEqualToString:@"ModuleA"]) {
        return YES;
    }
    return NO;
}

- (nonnull UIViewController *)connectURL:(nonnull NSURL *)URL params:(nonnull NSDictionary *)params {
    if (![self canOpenURL:URL]) {
        return nil;
    }
    CXModuleADetailViewController *moduleADetailViewController = [[CXModuleADetailViewController alloc] init];
    _moduleADetailViewController = moduleADetailViewController;
    return moduleADetailViewController;
}

- (void)deliveAprotocolModelBack:(void(^)(NSString *t))back {
    _moduleADetailViewController.handle_block_t = back;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
