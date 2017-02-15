//
//  AppDelegate.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/7.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "AppDelegate.h"
#import "LXJMainViewController.h"
#import "LXJLeftViewController.h"       
#import "RESideMenu.h"
#import "AppDelegate+LXJLocation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    LXJMainViewController *mainVC = [[LXJMainViewController alloc]init];
    LXJLeftViewController *leftVC = [[LXJLeftViewController alloc]init];
    
    RESideMenu *sideMenu = [[RESideMenu alloc]initWithContentViewController:mainVC leftMenuViewController:leftVC rightMenuViewController:nil];
    /* 盒子的背景图（左中右三个VC一张背景图拉伸） */
    sideMenu.backgroundImage = [UIImage imageNamed:@"bg_snow"];
    /* 滑动手势 */
    sideMenu.panFromEdge = YES;
    sideMenu.panGestureEnabled = YES;
    /* 阴影 */
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowEnabled = YES;
    /* 菜单控制器的状态栏颜色 */
    sideMenu.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    
    //定位
    //[self setupLocation];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController = sideMenu;
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
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
