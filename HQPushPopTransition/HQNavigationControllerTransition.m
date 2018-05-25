//
//  HQNavigationControllerTransition.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "HQNavigationControllerTransition.h"
#import "HQNavigationController.h"
#import "HQPushAnimationTransition.h"

@interface HQNavigationControllerTransition ()

@property(nonatomic, weak) HQNavigationController *navigationController;

/**
 * Percent Driven Interactive Transition.
 */
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePushTransition;
/**
 * Push animation transition.
 */
@property(nonatomic, strong) HQPushAnimationTransition *pushAnimTransition;

@end

@implementation HQNavigationControllerTransition

- (instancetype)initWithNavigationContollerViewController:(HQNavigationController *)navigationController
{
    if (self = [super init]) {
        _navigationController = navigationController;
    }
    return self;
}

- (void)gestureDidTriggered:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat progress = [gestureRecognizer translationInView:gestureRecognizer.view].x / gestureRecognizer.view.bounds.size.width;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        [self.interactivePushTransition updateInteractiveTransition:0];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (progress <= 0) {
            progress = fabs(progress);
            progress = MIN(1.0, MAX(0.0, progress));
        }
        else{
            progress = 0;
        }
        [self.interactivePushTransition updateInteractiveTransition:progress];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        if (fabs(progress) > 0.3) {
            [self.interactivePushTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePushTransition cancelInteractiveTransition];
        }
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationControxller
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimTransition;
    }
    
    return nil;
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.interactivePushTransition) {
        return self.interactivePushTransition;
    }
    
    return nil;
}


#pragma mark - Private

- (UIPercentDrivenInteractiveTransition *)interactivePushTransition{
    if (!_interactivePushTransition) {
        _interactivePushTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        _interactivePushTransition.completionCurve = UIViewAnimationCurveEaseOut;
    }
    return _interactivePushTransition;
}

- (HQPushAnimationTransition *)pushAnimTransition{
    if (!_pushAnimTransition) {
        _pushAnimTransition = [HQPushAnimationTransition new];
    }
    return _pushAnimTransition;
}

@end
