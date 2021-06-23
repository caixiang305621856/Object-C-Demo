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
 
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0), 1
     kCFRunLoopBeforeTimers = (1UL << 1), 2
     kCFRunLoopBeforeSources = (1UL << 2), 4
     kCFRunLoopBeforeWaiting = (1UL << 5), 32
     kCFRunLoopAfterWaiting = (1UL << 6), 64
     kCFRunLoopExit = (1UL << 7), 128
     kCFRunLoopAllActivities = 0x0FFFFFFFU
 };
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    CFRunLoopObserverRef runLoopObserverRef = CFRunLoopObserverCreate(
                                                                      CFAllocatorGetDefault(),
                                                                      kCFRunLoopAllActivities,
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
    
    
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"-----------viewDidLoad---------------");
    
    UIView *aView = [[UIView alloc] init];
    UIView *bView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor grayColor];
    bView.backgroundColor = [UIColor blueColor];

    [self.view addSubview:aView];
    [aView addSubview:bView];
    
    aView.layer.anchorPoint = CGPointMake(0, 0);
    aView.transform = CGAffineTransformMakeScale(2, 2);
    aView.frame = CGRectMake(100, 100, 100, 100);
    bView.frame = CGRectMake(0, 0, 50, 50);
    NSLog(@"bounds %@ -- bounds %@",NSStringFromCGRect(aView.bounds),NSStringFromCGRect(bView.bounds));
    NSLog(@"frame %@ -- frame %@",NSStringFromCGRect(aView.frame),NSStringFromCGRect(bView.frame));

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"-----------viewWillAppear---------------");
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"-----------viewDidAppear---------------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-touchesBegan--");
    self.view.backgroundColor = [UIColor grayColor];
    NSLog(@"-touchesBeganEnd--");
}


int sum(int n) {
    if (n == 1) return 1;
    return sum(n - 1) + n;
}

@end
