//
//  CXRunLoopViewController.m
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/11.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import "CXRunLoopViewController.h"

@interface CXRunLoopViewController ()
/*
    1.控制线程不被释放
    2.性能优化
    3.监控卡顿
 */
@end

@implementation CXRunLoopViewController

static void runLoopObserverCallBack (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}

/*
 runLoop节省CPU
 进modos 处理事件 CGD Timer
 port -> source1
 
 
 通知Observers 进入RunLoop
 通知Observers 即将处理Times
 通知Observers 即将处理Sources
 
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    CFRunLoopObserverRef runLoopObserverRef = CFRunLoopObserverCreate(
                                                                      CFAllocatorGetDefault(),
                                                                      kCFRunLoopEntry | kCFRunLoopBeforeWaiting |kCFRunLoopAfterWaiting,
                                                                      true,
                                                                      0xFFFFFF, //设置优先级低于CATransaction(2000000)
                                                                      runLoopObserverCallBack,
                                                                      NULL
                                                                      );
    CFRunLoopAddObserver(runLoopRef, runLoopObserverRef, kCFRunLoopCommonModes);
    CFRelease(runLoopObserverRef);
    
    
    
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^{
        NSLog(@"=====");
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-touchesBegan--");

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"-dispatch_async--");
    });
    NSLog(@"-touchesBeganEnd--");

}


@end
