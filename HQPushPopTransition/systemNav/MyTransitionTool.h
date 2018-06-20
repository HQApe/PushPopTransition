//
//  MyTransitionTool.h
//  HQPushPopTransition
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MyTransitionDelegate <NSObject>

@optional

- (void)transitionWillPushViewController;

- (void)transitionDidPushViewController;

- (BOOL)transitionShouldPopToViewController;

@end

@interface MyTransitionTool : NSObject<UINavigationControllerDelegate>

- (void)registerPushGestureViewController:(UIViewController<MyTransitionDelegate> *)viewController;
- (void)registerPopGestureViewController:(UIViewController *)viewController;

@end
