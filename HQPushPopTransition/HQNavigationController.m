//
//  HQNavigationController.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "HQNavigationController.h"
#import "HQNavigationControllerTransition.h"

#define JPScreenW [UIScreen mainScreen].bounds.size.width

@interface HQNavigationController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property(nonatomic, weak) id systemPopTarget;

@property(nonatomic, strong) HQNavigationControllerTransition *transition; //Transition

@end

@implementation HQNavigationController

- (UIPanGestureRecognizer *)panGesture
{
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] init];
        _panGesture.maximumNumberOfTouches = 1;
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (HQNavigationControllerTransition *)transition{
    if (_transition == nil) {
        _transition = [[HQNavigationControllerTransition alloc] initWithNavigationContollerViewController:self];
    }
    return _transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.panGesture]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        _systemPopTarget = [targets.firstObject valueForKey:@"target"];
        self.interactivePopGestureRecognizer.enabled = NO;
        [self.panGesture addTarget:self action:@selector(panGestureHandler:)];
    }
}

- (void)panGestureHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
        if (translation.x < 0) {
            //右——>左
            UIViewController *viewController = self.viewControllers.lastObject;
            if (!viewController) {
                return;
            }
            // ask delegate.
            if (self.navigationDelegate && [self.navigationDelegate respondsToSelector:@selector(navigationControllerDidPush:)]) {
                // handle pop transition animation by system.
                self.delegate = self.transition;
                
                [self.navigationDelegate navigationControllerDidPush:self];
            }
        }else {
            //左——>右
        }
    }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        // reset root navigation controller delegate.
        // if not do this, some unexpected error will happen when tap back button.
        self.delegate = nil;
        
        // remove target.
        [gestureRecognizer removeTarget:self.transition action:@selector(gestureDidTriggered:)];
        
    }
}

#pragma mark - Push Gesture Target

- (void)addPushAction:(UIPanGestureRecognizer *)gesture{
    // push action.
    [gesture addTarget:self.transition action:@selector(gestureDidTriggered:)];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    UIViewController *viewController = self.viewControllers.lastObject;
    if (!viewController) {
        return NO;
    }
    
    if (translation.x < 0) {
        
        // left slip, means push action.
        
        if (self.navigationDelegate && [self.navigationDelegate respondsToSelector:@selector(navigationControllerDidPush:)]) {
            [self addPushAction:gestureRecognizer];
            
            return YES;
        }
        
        return NO;
    }
    else{
        
        // right slip, means pop action.
        
        // Forbid pop when the start point beyond user setted range for pop.
//        CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
//        if (JPScreenW >= 0 && beginningLocation.x > JPScreenW) {
//            return NO;
//        }
//        else{
//            // forbid pop when transitioning.
//            if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
//                return NO;
//            }
//
//            // forbid pop when current viewController is root viewController.
//            if (self.viewControllers.count == 1) {
//                return NO;
//            }
//
//            // ask delegate.
//            if (self.navigationDelegate && [self.navigationDelegate respondsToSelector:@selector(navigationControllerShouldStartPop:)]) {
//                if (![self.navigationDelegate navigationControllerShouldStartPop:self]) {
//                    return NO;
//                }
//            }
//
//            // not use system pop action.
//            if (self.useCustomPopAnimationForCurrentViewController) {
//                return YES;
//            }
//
//            // use system pop action.
//            [self  addSystemPopAction:gestureRecognizer];
//        }
    }
    
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
