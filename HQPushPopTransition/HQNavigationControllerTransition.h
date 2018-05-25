//
//  HQNavigationControllerTransition.h
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQNavigationController;

@interface HQNavigationControllerTransition : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithNavigationContollerViewController:(HQNavigationController *)navigationController;

- (void)gestureDidTriggered:(UIPanGestureRecognizer *)gestureRecognizer;

@end
