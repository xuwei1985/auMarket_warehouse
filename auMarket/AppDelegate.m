//
//  AppDelegate.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/7.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (UINavigationController *)getNavigationController {
    return [[APP_DELEGATE booter] navigationController];
}

+ (UITabBarController *)getTabbarController {
    return [[APP_DELEGATE booter] tabBarController];
}

-(void)bootMainVc
{
    [self.window setRootViewController:[self.booter bootUIViewController]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.booter = [[Booter alloc] init];
    [self.booter bootReachability];

    SPNavigationController *navController = [[SPNavigationController alloc] initWithRootViewController:[[UserLoginViewController alloc] init]];
    [self.window setRootViewController:navController];
    self.window.backgroundColor=COLOR_WHITE;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_DID_ENTER_BACKGROUND object:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_WILL_ENTER_FOREGROUND object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL bRet = [self.booter onHandleOpenURL:url];
    return bRet;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL bRet = [self.booter onHandleOpenURL:url];
    return bRet;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //跳转处理支付结果
    BOOL bRet = [self.booter onHandleOpenURL:url];
    return bRet;
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //[JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
}

@end
