//
//  CXViewController.m
//  Object-C-Demo
//
//  Created by caixiang305621856 on 06/08/2021.
//  Copyright (c) 2021 caixiang305621856. All rights reserved.
//

#import "CXViewController.h"
#import "CXComponentManager.h"
#import "CXModuleAProtocol.h"
#import "Object_C_Demo_Example-Swift.h"

NSString * const kCellIdentifier = @"kCellIdentifier";

@interface CXViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [CXComponentManager initialize];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGRect rect = self.view.bounds;
    self.tableView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [CXComponentManager routeURL:[NSURL URLWithString:@"cxScheme://ModuleA"] withParameters:@{kLJRouteModeKey: @(ELJNavigationModePresent)}];
        id<CXModuleAProtocol> moduleAProtocol = [CXComponentManager serviceForProtocol:@protocol(CXModuleAProtocol)];
        [moduleAProtocol deliveAprotocolModelBack:^(NSString * _Nonnull t) {
            NSLog(@"%@",t);
        }];
//        UIViewController *v = [CXComponentManager viewControllerForURL:[NSURL URLWithString:@"cxScheme://ModuleA"]];
//        [self.navigationController pushViewController:v animated:YES];
    }
    
    if (indexPath.row == 1) {
        MySwiftObj *obj = [MySwiftObj new];
        [obj swiftTest];
    }
    
    if (indexPath.row == 2) {

    }
    
    if (indexPath.row == 3) {
       
    }
    
    if (indexPath.row == 4) {
      
    }
    
    if(indexPath.row == 5) {
        
    }
    
    if (indexPath.row == 6) {
      
    }
    
    if (indexPath.row == 7) {
        
    }
}

#pragma mark - getters and setters

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[@"block本质",@"swift"];
    }
    return _dataSource;
}


@end
