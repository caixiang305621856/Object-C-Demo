//
//  CXDebugTipViewController.h
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXDebugTipViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL isparamsError;
@property (nonatomic, assign, readonly) BOOL isNotURLSupport;
@property (nonatomic, assign, readonly) BOOL isNotFound;

+ (nonnull UIViewController *)paramsErrorTipController;

+ (nonnull UIViewController *)notURLTipController;

+ (nonnull UIViewController *)notFoundTipConctroller;

- (void)showDebugTipController:(nonnull NSURL *)URL
               withParameters:(nullable NSDictionary *)parameters;

@end

/**
 * @category NavigationTip
 *  中间件导航的错误提示
 */
@interface UIViewController (NavigationTip)

/**
 * URL可导航，参数错误无法生成ViewController
 */
+(nonnull UIViewController *)lj_paramsError;

/**
 * URL可导航，但是提供者并没有对URL返回一个ViewController
 */
+(nonnull UIViewController *)lj_notURLController;


/**
 * URL不可导航，提示用户无法通过LJComponentManager导航
 */
+(nonnull UIViewController *)lj_notFound;
@end

NS_ASSUME_NONNULL_END
