//
//  HQPushAnimationTransition.h
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQPushAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>

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
 *  Animate Transition.
 */
- (void)animateTransition;

/**
 *  Complete transition.
 */
- (void)transitionComplete;

@end
