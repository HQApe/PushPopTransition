//
//  HQPushAnimationTransition.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "HQPushAnimationTransition.h"

#define KScreenH [UIScreen mainScreen].bounds.size.height
#define KScreenW [UIScreen mainScreen].bounds.size.width

const CGFloat KMixShadowViewShadowWidth = 21.f;
const CGFloat KBaseAnimationTransitionInterlaceFactor = 0.3f;

@interface HQPushAnimationTransition()
/**
 *  From view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

/**
 *  Target view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  Container view.
 */
@property (nonatomic, readonly, weak) UIView *containerView;

/**
 *  TransitionContext.
 */
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;


@property(nonatomic, strong) UIView *toShadowView_anim;

@end

@implementation HQPushAnimationTransition

//Protocol require
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

//Protocol require
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    [self animateTransition];
}

//Protocol optional
- (void)animateTransition{
    
    self.fromViewController.view.frame = CGRectMake(0, 0, KScreenW, KScreenH);
    [self.containerView addSubview:self.fromViewController.view];
    
    CGRect toViewFrame = CGRectMake(0, KScreenH - KMixShadowViewShadowWidth, KScreenW, KScreenH + KMixShadowViewShadowWidth);
    self.toShadowView_anim.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(0, KMixShadowViewShadowWidth, KScreenW, KScreenH);
    [self.toShadowView_anim addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toShadowView_anim];
    
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect fromViewFrame = self.fromViewController.view.frame;
        fromViewFrame.origin.y = -KBaseAnimationTransitionInterlaceFactor * KScreenH;
        self.fromViewController.view.frame = fromViewFrame;
        
        CGRect toViewframe = self.toShadowView_anim.frame;
        toViewframe.origin.y = -KMixShadowViewShadowWidth;
        self.toShadowView_anim.frame = toViewframe;
        
    } completion:^(BOOL finished) {
        
        [self.toViewController.view removeFromSuperview];
        self.toViewController.view.frame = CGRectMake(0, 0, KScreenW, KScreenH);
        [self.containerView addSubview:self.toViewController.view];
        [self transitionComplete];
        [self.toShadowView_anim removeFromSuperview];
        
    }];
}

#pragma mark - Private
- (void)transitionComplete {
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

- (UIView *)toShadowView_anim{
    if (!_toShadowView_anim) {
        _toShadowView_anim = [UIView new];
        _toShadowView_anim.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return _toShadowView_anim;
}

@end
