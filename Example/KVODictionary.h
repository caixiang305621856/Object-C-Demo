//
//  KVODictionary.h
//  FaceTraningForManager
//
//  Created by caixiang on 2020/5/1.
//  Copyright © 2020年 aopeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVODictionary : NSObject

@property (strong, nonatomic,readonly) NSMutableArray *allKeys;

@property (strong, nonatomic,readonly)NSMutableDictionary *dictionary;

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)removeObjectForKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
