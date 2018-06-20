//
//  MyNavigationController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MyNavigationController.h"
#import "MyTransitionTool.h"

@interface MyNavigationController ()<UIGestureRecognizerDelegate>
/**
 * System pop gesture target.
 */
@property(nonatomic, weak) id systemPopTarget;

@property (strong, nonatomic) UIPanGestureRecognizer *popGesture;

@property (strong, nonatomic) MyTransitionTool *transition;

@end

@implementation MyNavigationController

- (UIPanGestureRecognizer *)popGesture
{
    if (_popGesture == nil) {
        _popGesture = [[UIPanGestureRecognizer alloc] init];
        _popGesture.maximumNumberOfTouches = 1;
        _popGesture.delegate = self;
    }
    return _popGesture;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // forbid pop when current viewController is root viewController.
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (translation.x > 0 && translation.x > fabs(translation.y)) { //左----------》右
        if (self.viewControllers.count == 1) {
            return NO;
        }
        return YES;
    }
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.popGesture]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.popGesture];
        self.interactivePopGestureRecognizer.enabled = NO;
        id target = self.interactivePopGestureRecognizer.delegate;
        [self.popGesture addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    }
    
//    self.transition = [[MyTransitionTool alloc] init];
//    [self.transition registerPopGestureViewController:self];
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
