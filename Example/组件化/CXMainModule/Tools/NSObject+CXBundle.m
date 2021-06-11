//
//  NSBundle+CXBundle.m
//  CXLY-Parts
//
//  Created by 蔡翔 on 16/9/13.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "NSObject+CXBundle.h"

@implementation NSObject (CXBundle)

//static NSBundle * _currentBundle;

+ (NSBundle *)currentBundle {

    NSBundle *bundle = [NSBundle bundleForClass:self];
    return bundle;
//    if (_currentBundle == nil) {
//        NSArray *frames = [NSBundle allFrameworks];
//        for (NSBundle *bundle in frames) {
//            NSString *bundleName = bundle.bundleURL.lastPathComponent;
//            if ([bundleName containsString:@"DiscoverModule"]) {
//                _currentBundle = bundle;
//                break;
//            }
//        }
//    }
//    if (_currentBundle == nil) {
//        return [NSBundle mainBundle];
//    }
//    return _currentBundle;
}

@end
