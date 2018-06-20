//
//  MythirdViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MythirdViewController.h"
#import "MyFirstViewController.h"

@interface MythirdViewController ()

@end

@implementation MythirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"Third";
    
    UIButton *pushBtn = [[UIButton alloc] init];
    pushBtn.frame = CGRectMake(100, 100, 100, 100);
    [pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}

- (void)push {
    MyFirstViewController *first = [[MyFirstViewController alloc] init];
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
