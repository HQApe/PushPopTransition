//
//  HQNavigationController.h
//  HQPushPopTransition
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQNavigationController;
@protocol HQNavigationControllerDelegate <NSObject>

@optional

-(void)navigationControllerDidPush:(HQNavigationController *)navigationController;
-(BOOL)navigationControllerShouldStartPop:(HQNavigationController *)navigationController;

@end

@interface HQNavigationController : UINavigationController

@property (weak, nonatomic) id<HQNavigationControllerDelegate> navigationDelegate;

@end
