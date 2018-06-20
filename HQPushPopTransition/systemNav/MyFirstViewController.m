//
//  MyFirstViewController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MyFirstViewController.h"
#import "MySecondViewController.h"

#import "MyTransitionTool.h"

@interface MyFirstViewController ()<MyTransitionDelegate>

@property (strong, nonatomic) MyTransitionTool *transition;

@end

@implementation MyFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"First";
    self.view.backgroundColor = [UIColor whiteColor];
    self.transition = [[MyTransitionTool alloc] init];
    
    [self.transition registerPushGestureViewController:self];
//    [self.transition registerPopGestureViewController:self];
}

#pragma mark - MyTransitionDelegate
- (void)transitionWillPushViewController {
    [self pushToSecond];
}

- (void)transitionDidPushViewController {
    NSLog(@"%s", __func__);
}

#pragma mark - Private
- (void)pushToSecond {
    MySecondViewController *secondVc = [[MySecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
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
