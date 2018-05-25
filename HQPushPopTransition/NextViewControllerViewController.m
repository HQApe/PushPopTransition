//
//  NextViewControllerViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NextViewControllerViewController.h"

@interface NextViewControllerViewController ()

@end

@implementation NextViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
}

- (void)popToView
{
    [self.navigationController popViewControllerAnimated:YES];
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
