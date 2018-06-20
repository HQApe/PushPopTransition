//
//  MySecondViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MySecondViewController.h"
#import "MyTransitionTool.h"
#import "MythirdViewController.h"
@interface MySecondViewController ()<MyTransitionDelegate>

@property (strong, nonatomic) MyTransitionTool *transition;
@end

@implementation MySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"second";
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.transition = [[MyTransitionTool alloc] init];
    
    [self.transition registerPushGestureViewController:self];
    [self.transition registerPopGestureViewController:self];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)transitionWillPushViewController {
    MythirdViewController *vc = [[MythirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
