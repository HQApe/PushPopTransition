//
//  HQPushAnimationTransition.m
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "HQPushAnimationTransition.h"

#define JPScreenH [UIScreen mainScreen].bounds.size.height
#define JPScreenW [UIScreen mainScreen].bounds.size.width

const CGFloat JPMixShadowViewShadowWidth = 21.f;
const CGFloat JPBaseAnimationTransitionInterlaceFactor = 0.3f;

@interface HQPushAnimationTransition()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@property(nonatomic, strong) UIView *toShadowView_anim;

@property(nonatomic, strong) UIImageView *fromImv_anim;

@end

@implementation HQPushAnimationTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    [self animateTransition];
}

- (void)animateTransition{
    
    BOOL tabbarIsHidden = self.toViewController.hidesBottomBarWhenPushed;
    
    if (tabbarIsHidden) {
        // hide tabbar.
        [self animateTransitionForHiddenTabbar];
    }
    else{
        [self animateTransitionForDisplayTabbar];
    }
}

- (void)transitionComplete {
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

#pragma mark - Animation

- (void)animateTransitionForHiddenTabbar{
    
    UIImage *fromImg = [self jp_captureCurrentView:self.fromViewController.view.window];
    self.fromImv_anim.image = fromImg;
    self.fromImv_anim.frame = CGRectMake(0, 0, JPScreenW, JPScreenH);
    [self.containerView addSubview:self.fromImv_anim];
    
    CGRect toViewFrame = CGRectMake(JPScreenW - JPMixShadowViewShadowWidth, 0, JPScreenW + JPMixShadowViewShadowWidth, JPScreenH);
    self.toShadowView_anim.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(JPMixShadowViewShadowWidth, 0, JPScreenW, JPScreenH);
    [self.toShadowView_anim addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toShadowView_anim];
    
    // hide tabbar.
//    UITabBar *tabbar = [self fetchTabbar];
//    if (tabbar) {
//        tabbar.hidden = YES;
//    }
    
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect fromViewFrame = self.fromImv_anim.frame;
        fromViewFrame.origin.x = -JPBaseAnimationTransitionInterlaceFactor * JPScreenW;
        self.fromImv_anim.frame = fromViewFrame;
        
        CGRect toViewframe = self.toShadowView_anim.frame;
        toViewframe.origin.x = -JPMixShadowViewShadowWidth;
        self.toShadowView_anim.frame = toViewframe;
        
    } completion:^(BOOL finished) {
        
        [self.toViewController.view removeFromSuperview];
        self.toViewController.view.frame = CGRectMake(0, 0, JPScreenW, JPScreenH);
        [self.containerView addSubview:self.toViewController.view];
        [self transitionComplete];
        self.fromImv_anim.image = nil;
        [self.fromImv_anim removeFromSuperview];
        [self.toShadowView_anim removeFromSuperview];
        
//        tabbar.hidden = NO;
    }];
}

- (void)animateTransitionForDisplayTabbar{
    
    self.fromViewController.view.frame = CGRectMake(0, 0, JPScreenW, JPScreenH);
    [self.containerView addSubview:self.fromViewController.view];
    
    CGRect toViewFrame = CGRectMake(JPScreenW - JPMixShadowViewShadowWidth, 0, JPScreenW + JPMixShadowViewShadowWidth, JPScreenH);
    self.toShadowView_anim.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(JPMixShadowViewShadowWidth, 0, JPScreenW, JPScreenH);
    [self.toShadowView_anim addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toShadowView_anim];
    
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect fromViewFrame = self.fromViewController.view.frame;
        fromViewFrame.origin.x = -JPBaseAnimationTransitionInterlaceFactor * JPScreenW;
        self.fromViewController.view.frame = fromViewFrame;
        
        CGRect toViewframe = self.toShadowView_anim.frame;
        toViewframe.origin.x = -JPMixShadowViewShadowWidth;
        self.toShadowView_anim.frame = toViewframe;
        
    } completion:^(BOOL finished) {
        
        [self.toViewController.view removeFromSuperview];
        self.toViewController.view.frame = CGRectMake(0, 0, JPScreenW, JPScreenH);
        [self.containerView addSubview:self.toViewController.view];
        [self transitionComplete];
        [self.toShadowView_anim removeFromSuperview];
        
    }];
}


- (UIImage *)jp_captureCurrentView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Private

- (UIImageView *)fromImv_anim{
    if (!_fromImv_anim) {
        _fromImv_anim = [UIImageView new];
    }
    return _fromImv_anim;
}

- (UIView *)toShadowView_anim{
    if (!_toShadowView_anim) {
        _toShadowView_anim = [UIView new];
    }
    return _toShadowView_anim;
}

@end
