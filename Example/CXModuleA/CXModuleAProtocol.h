//
//  CXModuleAProtocol.h
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXConnectorProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CXModuleAProtocol <CXConnectorProtocol>
//自定义 自己为外界提供的协议！

- (void)deliveAprotocolModelBack:(void(^)(NSString *t))back;

@end

NS_ASSUME_NONNULL_END
