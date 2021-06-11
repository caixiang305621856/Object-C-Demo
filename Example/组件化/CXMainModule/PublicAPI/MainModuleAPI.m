//
//  MainModuleAPI.m
//  主要骨架
//
//  Created by 蔡翔 on 16/10/19.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "MainModuleAPI.h"
#import "CXTabBar.h"
#import "CXTabBarController.h"
#import "CXNavBar.h"
#import "CXMiddleView.h"

@implementation MainModuleAPI

+ (CXTabBarController *)rootTabBarCcontroller {
    return [CXTabBarController shareInstance];
}


+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {

    [[CXTabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];

}


+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {

    CXTabBar *tabbar = (CXTabBar *)[CXTabBarController shareInstance].tabBar;
    tabbar.middleClickBlock = middleClickBlock;

}

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)setNavBarGlobalBackGroundImage: (UIImage *)globalImg {
    [CXNavBar setGlobalBackGroundImage:globalImg];
}
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize {

    [CXNavBar setGlobalTextColor:globalTextColor andFontSize:fontSize];

}

+ (UIView *)middleView {
    return [CXMiddleView middleView];
}


@end
