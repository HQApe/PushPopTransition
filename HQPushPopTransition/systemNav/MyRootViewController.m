//
//  MyRootViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MyRootViewController.h"
#import "MyFirstViewController.h"
@interface MyRootViewController ()

@end

@implementation MyRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Root";
    self.view.backgroundColor = [UIColor purpleColor];
    UIButton *pushBtn = [[UIButton alloc] init];
    pushBtn.frame = CGRectMake(100, 100, 100, 100);
    [pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}

- (void)push {
    MyFirstViewController *first = [[MyFirstViewController alloc] init];
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
