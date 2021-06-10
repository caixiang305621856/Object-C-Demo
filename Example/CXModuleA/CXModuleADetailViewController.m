//
//  CXModuleADetailViewController.m
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/8.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

#import "CXModuleADetailViewController.h"

@interface CXModuleADetailViewController ()

@end

@implementation CXModuleADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    !self.handle_block_t?:self.handle_block_t(@"123456");
    [self didTappedReturnButton:sender];
}

- (void)didTappedReturnButton:(UIButton *)button {
    if (self.navigationController == nil) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        if (self.parentViewController) {
            
            [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
