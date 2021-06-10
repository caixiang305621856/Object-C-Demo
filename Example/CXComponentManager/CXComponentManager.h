//
//  CXComponentManager.h
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  中间件向调用者提供:
 *  (1)baseViewController的传递key: kLJRouteViewControllerKey
 *  (2)newController导航方式的传递key: kLJRouteModeKey
 *  (3)LJNavigator.h定义了目前支持的导航方式有三种；
 */
#import "LJNavigator.h"
FOUNDATION_EXTERN NSString *__nonnull const kLJRouteViewControllerKey;
FOUNDATION_EXTERN NSString *__nonnull const kLJRouteModeKey;

NS_ASSUME_NONNULL_BEGIN

@interface CXComponentManager : NSObject

//注册挂载
+ (id)registerConnector:(nonnull Protocol*)protocol;

// 判断某个URL能否导航
+ (BOOL)canRouteURL:(nonnull NSURL *)URL;

// 通过URL直接完成页面跳转
+ (BOOL)routeURL:(nonnull NSURL *)URL;
+ (BOOL)routeURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params;

// 通过URL获取viewController实例
+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL;
+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params;

// 根据protocol获取实现CXConnectorProtocol协议实例
+ (nullable id)serviceForProtocol:(nonnull Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
