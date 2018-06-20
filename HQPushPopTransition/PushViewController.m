//
//  PushViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "PushViewController.h"

#import "NextViewControllerViewController.h"
#import "HQNavigationController.h"

@interface PushViewController ()<HQNavigationControllerDelegate>

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushToViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)pushToViewController
{
    NextViewControllerViewController *vc = [[NextViewControllerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popToView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)navigationControllerShouldStartPop:(HQNavigationController *)navigationController
{
    return YES;
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
