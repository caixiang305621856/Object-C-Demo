//
//  KVODictionary.m
//  FaceTraningForManager
//
//  Created by caixiang on 2020/5/1.
//  Copyright © 2020年 aopeng. All rights reserved.
//

#import "KVODictionary.h"

@interface KVODictionary()

@property (strong, nonatomic) NSMutableArray *allKeys;
@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation KVODictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    [self.dictionary setObject:anObject forKey:aKey];
    NSMutableArray *allK = [self mutableArrayValueForKey:@"allKeys"];
    if ([allK containsObject:aKey]) {
        NSInteger idx = [allK indexOfObject:aKey];
        [allK replaceObjectAtIndex:idx withObject:aKey];
    } else {
        [allK addObject:aKey];
    }
}

- (void)removeObjectForKey:(id)aKey {
    NSMutableArray *allK = [self mutableArrayValueForKey:@"allKeys"];
    if ([allK containsObject:aKey]) {
        [self.dictionary removeObjectForKey:aKey];
        [allK removeObject:aKey];
    }
}

- (NSMutableDictionary *)dictionary {
    if (_dictionary == nil) {
        _dictionary = [NSMutableDictionary dictionary];
    }
    return _dictionary;
}

- (NSMutableArray *)allKeys {
    if (_allKeys == nil) {
        _allKeys = [NSMutableArray arrayWithArray:[self.dictionary allKeys]];
    }
    return _allKeys;
}

@end
