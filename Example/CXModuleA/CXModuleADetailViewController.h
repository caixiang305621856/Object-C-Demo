//
//  CXModuleADetailViewController.h
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXModuleADetailViewController : UIViewController

@property (strong, nonatomic) void (^handle_block_t)(NSString *string);

@end

NS_ASSUME_NONNULL_END
