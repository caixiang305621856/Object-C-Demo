//
//  UIView+CXNib.m
//  百思不得姐
//
//  Created by 蔡翔 on 16/6/22.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "UIView+CXNib.h"
#import "NSObject+CXBundle.h"

@implementation UIView (CXNib)

+ (instancetype)loadFromNib {

    UIView *view = [[self currentBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return view;

}

- (UIViewController *)currentViewController
{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
