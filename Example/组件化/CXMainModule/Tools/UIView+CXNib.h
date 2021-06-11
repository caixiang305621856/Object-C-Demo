//
//  UIView+CXNib.h
//  百思不得姐
//
//  Created by 蔡翔 on 16/6/22.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CXNib)

+ (instancetype)loadFromNib;

/**
 *  返回当前视图, 所处的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)currentViewController;

@end
