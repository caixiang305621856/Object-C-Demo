//
//  CXComponentManager.m
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import "CXComponentManager.h"
#import "CXConnectorProtocol.h"
#import "CXDebugTipViewController.h"
#import "LJNavigator.h"
#import <objc/runtime.h>

NSString *__nonnull const kLJRouteViewControllerKey = @"LJRouteViewController";
NSString *__nonnull const kLJRouteModeKey = @"LJRouteType";

// 全部保存各个模块的connector实例
static NSMutableDictionary<NSString *, id<CXConnectorProtocol>> *connectorMap = nil;
// 全部保存各个模块的子类协议class
static NSCache<NSString *, Class> *classMapCache = nil;


@implementation CXComponentManager
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (classMapCache == nil) {
            classMapCache = [[NSCache alloc] init];
            classMapCache.countLimit = 40;
        }
        if (connectorMap == nil) {
            connectorMap = [[NSMutableDictionary alloc] init];
        }
        [self _loadClassesConfirmToProtocol:@protocol(CXConnectorProtocol)];
    });
}

//注册挂载
+ (id)registerConnector:(nonnull Protocol*)protocol {
    NSString *key = NSStringFromProtocol(protocol);
    id instance = [connectorMap objectForKey:key];
    if (instance) {
        return instance;
    }
    Class class = [self _findClassForProtocol:protocol];
    if (class) {
        instance = [[class alloc]init];
        [connectorMap setObject:instance forKey:key];
    }
    return instance;
}

// 判断某个URL能否导航
+ (BOOL)canRouteURL:(nonnull NSURL *)URL {
    if (!connectorMap || connectorMap.count == 0) return NO;
    __block BOOL success = NO;
    [connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<CXConnectorProtocol>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(canOpenURL:)]) {
            if ([obj canOpenURL:URL]) {
                success = YES;
                *stop = YES;
            }
        }
    }];
    return success;
}

// 通过URL直接完成页面跳转
+ (BOOL)routeURL:(nonnull NSURL *)URL {
    return [self routeURL:URL withParameters:nil];

}
+ (BOOL)routeURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params {
    if (!connectorMap || connectorMap.count == 0) return NO;
    __block BOOL success = NO;
    __block int queryCount = 0;
    NSDictionary *userParams = [self _userParametersWithURL:URL andParameters:params];
    [connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<CXConnectorProtocol>  _Nonnull obj, BOOL * _Nonnull stop) {
        queryCount ++;
        if ([obj respondsToSelector:@selector(connectURL:params:)]) {
            
            id returnObj = [obj connectURL:URL params:userParams];
            if (returnObj && [returnObj isKindOfClass:[UIViewController class]]) {
                
                if ([returnObj class] == [UIViewController class]) {
                    success = YES;
                } else if([returnObj isKindOfClass:[CXDebugTipViewController class]]) {
                    CXDebugTipViewController *tipVC = (CXDebugTipViewController*)returnObj;
                    if (tipVC.isNotURLSupport) {
                        success = YES;
                    } else{
                        success = NO;
#if DEBUG
                        [tipVC showDebugTipController:URL withParameters:params];
                        success = YES;
#endif
                    }
                } else {
                    [[LJNavigator getInstance] hookShowURLController:returnObj baseViewController:params[kLJRouteViewControllerKey] routeMode:params[kLJRouteModeKey]?[params[kLJRouteModeKey] intValue]:ELJNavigationModePush];
                    success = YES;
                }
                
            }
            *stop = YES;
        }
    }];
    
#if DEBUG
    if (!success && queryCount == connectorMap.count) {
        [((CXDebugTipViewController *)[UIViewController lj_notFound]) showDebugTipController:URL withParameters:params];
        return nil;
    }
#endif
    return success;
}

// 通过URL获取viewController实例
+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL {
    return [self viewControllerForURL:URL withParameters:nil];
}

+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params {
    if(!connectorMap || connectorMap.count <= 0) return nil;
    __block UIViewController *returnObj = nil;
    __block int queryCount = 0;
    NSDictionary *userParams = [self _userParametersWithURL:URL andParameters:params];
    [connectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<CXConnectorProtocol>  _Nonnull obj, BOOL * _Nonnull stop) {
        queryCount ++;
        if ([obj respondsToSelector:@selector(connectURL:params:)]) {
            returnObj = [obj connectURL:URL params:userParams];
            if ([returnObj isKindOfClass:[UIViewController class]]) {
                *stop = YES;
            }
        }
    }];
    
    
#if DEBUG
    if (!returnObj && queryCount == connectorMap.count) {
        [((CXDebugTipViewController *)[UIViewController lj_notFound]) showDebugTipController:URL withParameters:params];
        return nil;
    }
#endif

    
    return returnObj;
}

// 根据protocol获取实现CXConnectorProtocol协议实例
+ (nullable id)serviceForProtocol:(nonnull Protocol *)protocol {
    return [self registerConnector:protocol];
}

#pragma mark - private
+ (void)_loadClassesConfirmToProtocol:(Protocol *)protocol {
    unsigned int classCount;
    Class* clsList = objc_copyClassList(&classCount);
    for (int i = 0; i < classCount; i ++) {
        const char *className = class_getName(clsList[i]);
        Class cls = objc_getClass(className);
        if (class_conformsToProtocol(cls, protocol)) {
            const char *protocolName = protocol_getName([self _firstProtocolForClass:cls]);
            NSString *pn = [NSString stringWithUTF8String:protocolName];
            //会触发 cls initialize 方法
            [classMapCache setObject:cls forKey:pn];
        }
    }
    free(clsList);
}

/// 获取实现类协议列表的第一个协议（需要约定的）
/// @param cls 实现类
+ (Protocol *)_firstProtocolForClass:(Class)cls {
    unsigned int protocolCount;
    Protocol * __unsafe_unretained _Nonnull * _Nullable protocols = class_copyProtocolList(cls, &protocolCount);
    Protocol *protocol = protocols[0];
    free(protocols);
    return protocol;
}

+ (Class<CXConnectorProtocol>)_findClassForProtocol:(Protocol*)protocol {
    NSString *key = NSStringFromProtocol(protocol);
    Class cacheClass = [classMapCache objectForKey:key];
    if (cacheClass) {
        //已经缓存的协议实现类
        return cacheClass;
    } else {
        //未缓存的协议实现类
        Class<CXConnectorProtocol> responseClass = [self _assertForMoudleWithProtocol:protocol];
        if (responseClass) {
            const char *protocolName = protocol_getName([self _firstProtocolForClass:responseClass]);
            NSString *pn = [NSString stringWithUTF8String:protocolName];
            [classMapCache setObject:responseClass forKey:pn];
        }
        return responseClass;
    }
    return nil;
}

+ (Class)_assertForMoudleWithProtocol:(Protocol *)p {
    unsigned int classCount;
    Class* clsList = objc_copyClassList(&classCount);
    Class thisClass = nil;
    for (int i = 0; i < classCount; i ++) {
        const char *className = class_getName(clsList[i]);
        Class cls = objc_getClass(className);
        if (class_conformsToProtocol(cls, p)) {
            thisClass = cls;
        }
    }
    free(clsList);
    if (thisClass == nil) {
        NSString *protocolName = NSStringFromProtocol(p);
        NSString *reason = [NSString stringWithFormat: @"找不到协议 %@ 对应的接口的 实现类", protocolName];
        NSLog(@"模块协议异常⚠️:%@",reason);
    }
    return thisClass;
}

/**
 * 从url获取query参数放入到参数列表中
 */
+ (NSDictionary *)_userParametersWithURL:(nonnull NSURL *)URL andParameters:(nullable NSDictionary *)params {
    
    NSArray *pairs = [URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *userParams = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *key = [kv objectAtIndex:0];
            NSString *value = [self _URLDecodedString:[kv objectAtIndex:1]];
            [userParams setObject:value forKey:key];
        }
    }
    [userParams addEntriesFromDictionary:params];
    return [NSDictionary dictionaryWithDictionary:userParams];
}

/**
 * 对url的value部分进行urlDecoding
 */
+ (nonnull NSString *)_URLDecodedString:(nonnull NSString *)urlString {
    return [urlString stringByRemovingPercentEncoding];
}

@end
