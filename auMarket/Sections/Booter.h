//
//  YPUIBooter.h
//  Youpin
//
//  Created by douj on 15/4/15.
//  Copyright (c) 2015年 youpin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "AlertBlockView.h"
#import "SyncManager.h"
#import "BadgeManager.h"
#import "AccountManager.h"
#import "SPNavigationController.h"
#import "SPBaseModel.h"
#import "SPRedirect.h"
#import "SPTabBarItem.h"
#import <AdSupport/AdSupport.h>
#import "SPTabBarController.h"
#import "IntroViewController.h"
#import "BooterModel.h"
#import "MemberLoginModel.h"
#import "PassValueDelegate.h"

@interface Booter : NSObject<UIGestureRecognizerDelegate,UITabBarControllerDelegate,SPBaseModelProtocol>

@property (nonatomic,strong) UINavigationController* navigationController;
@property (nonatomic,strong) UITabBarController* tabBarController;
@property (nonatomic,strong) BooterModel *model;
@property (nonatomic,strong) MemberLoginModel *loginModel;
@property (nonatomic,strong) NSArray<ParkingItemEntity *> *parkinglist;

// 获取引导页
-(UIViewController*)getIntroViewController;
// 初始化UI
-(UIViewController*)bootUIViewController;
// 初始化启动广告页
-(UIViewController*)bootStartPage;
-(void)registRemoteNotification;
//初始化UMeng统计
-(void)bootUMeng;
//初始化极光推送
-(void)bootJPush:(NSDictionary *)launchOptions;
//sync接口
-(void)sync;
//外部回调
-(BOOL)onHandleOpenURL:(NSURL *)url;
//网络检测
- (void)bootReachability;
-(void)loadParkingList;
@end
