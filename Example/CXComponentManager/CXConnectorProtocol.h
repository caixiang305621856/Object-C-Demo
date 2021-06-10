//
//  CXConnectorProtocol.h
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;
@protocol CXConnectorProtocol <NSObject>

- (BOOL)canOpenURL:(NSURL *)URL;

- (UIViewController *)connectURL:(NSURL *)URL params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
