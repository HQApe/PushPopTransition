//
//  MyTransitionTool.m
//  HQPushPopTransition
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MyTransitionTool.h"
#import "HQPushAnimationTransition.h"

@interface MyTransitionTool ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) UINavigationController *navigationController;
@property (weak, nonatomic) id<MyTransitionDelegate> pushDelegate;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePushTransition;

@property(nonatomic, strong) HQPushAnimationTransition *pushAnimTransition;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property(nonatomic, weak) id systemPopTarget;

@end

@implementation MyTransitionTool

- (void)registerPushGestureViewController:(UIViewController<MyTransitionDelegate> *)viewController {
    _pushDelegate = viewController;
    _navigationController = viewController.navigationController;
    [viewController.view addGestureRecognizer:self.panGesture];
}

- (void)registerPopGestureViewController:(UIViewController *)viewController {
    [viewController.view addGestureRecognizer:self.panGesture];
    viewController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    _systemPopTarget = viewController.navigationController.interactivePopGestureRecognizer.delegate;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
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

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    _navigationController.delegate = nil;
    if ([self.pushDelegate respondsToSelector:@selector(transitionDidPushViewController)]) {
        [self.pushDelegate transitionDidPushViewController];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if ((translation.y < 0 && translation.y < -fabs(translation.x))) {
        if ([self.pushDelegate respondsToSelector:@selector(transitionWillPushViewController)]) {
            [self addPushGestrueTarget:gestureRecognizer];
        }
        return YES;
    }else if (translation.x > 0 && translation.x > fabs(translation.y)) {
        if (_systemPopTarget) {
            [self addPopGestrueTarget:gestureRecognizer];
        }
        return YES;
    }
    return NO;
}

#pragma mark - Action
- (void)pushGestureHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat progress = [gestureRecognizer translationInView:gestureRecognizer.view].y / gestureRecognizer.view.bounds.size.height;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
        if ((translation.y < 0 && translation.y < -fabs(translation.x))) {
            
            _navigationController.delegate = self;
            if ([self.pushDelegate respondsToSelector:@selector(transitionWillPushViewController)]) {
                [self.pushDelegate transitionWillPushViewController];
            }
            [self.interactivePushTransition updateInteractiveTransition:0.1];
        }
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
        
        [self removeAllGestureTarget:gestureRecognizer];
        if (fabs(progress) > 0.3) {//完成转场，交给navigationController的代理去置nil；
            [self.interactivePushTransition finishInteractiveTransition];
        }
        else {
            _navigationController.delegate = nil;//取消转场，navigationController代理要置nil，就不会走代理了
            [self.interactivePushTransition cancelInteractiveTransition];
        }
    }
}

- (void)popGestureHandler:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (translation.x > 0 && translation.x > fabs(translation.y)) {
        SEL popSel = NSSelectorFromString(@"handleNavigationTransition:");
        [gestureRecognizer addTarget:self.systemPopTarget action:popSel];
    }
}

- (void)removeAllGestureTarget:(UIPanGestureRecognizer *)gestureRecognizer {
    [self removePushGestureTarget:gestureRecognizer];
    [self removePopGestureTarget:gestureRecognizer];
}

- (void)addPushGestrueTarget:(UIPanGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer addTarget:self action:@selector(pushGestureHandler:)];
}

- (void)addPopGestrueTarget:(UIPanGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer addTarget:self action:@selector(popGestureHandler:)];
}


- (void)removePushGestureTarget:(UIPanGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer removeTarget:self action:@selector(pushGestureHandler:)];
}

- (void)removePopGestureTarget:(UIPanGestureRecognizer *)gestureRecognizer {
    SEL popSel = NSSelectorFromString(@"handleNavigationTransition:");
    [gestureRecognizer removeTarget:_systemPopTarget action:popSel];
}


#pragma mark - Getter
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

- (UIPanGestureRecognizer *)panGesture
{
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] init];
        _panGesture.maximumNumberOfTouches = 1;
        [_panGesture addTarget:self action:@selector(pushGestureHandler:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

@end
