//
//  RootViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "RootViewController.h"
#import "PushViewController.h"
#import "HQNavigationController.h"
@interface RootViewController ()<JPNavigationControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushToViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    HQNavigationController *nav = (HQNavigationController *)self.navigationController;
    nav.navigationDelegate = self;
}


- (void)pushToViewController
{
    PushViewController *vc = [[PushViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationControllerDidPush:(HQNavigationController *)navigationController
{
    [self pushToViewController];
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
