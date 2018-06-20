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

/**
 实现该代理方法，在方法中push到下一个Controller
 */
- (void)transitionWillPushViewController;

/**
 当控制器push完成后的回调
 */
- (void)transitionDidPushViewController;

/**
 是否允许pop手势返回
 */
- (BOOL)transitionShouldPopToViewController;

@end

@interface MyTransitionTool : NSObject<UINavigationControllerDelegate>

/**
 注册push过场手势
 */
- (void)registerPushGestureViewController:(UIViewController<MyTransitionDelegate> *)viewController;

/**
 注册pop返回手势，此处需注意在工程NavigationController或其它地方，是否实现了系统的pop返回手势！！！！，否则会有冲突。
 因此，该工具不需要嵌入原有的NavigationController设置。如果要全局添加的话，在NavigationController中注册即可，暂时还有个bug，要第二次才能触发（*********有时间解决下**********）。
 */
- (void)registerPopGestureViewController:(UIViewController *)viewController;

@end
