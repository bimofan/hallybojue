//
//  AppDelegate.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/6/30.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "XGPush.h"
#import "Constants.h"
#import "NSUserDefaultKeys.h"
#import "UserInfo.h"
#import "GetIPAddress.h"





@interface AppDelegate () <UISplitViewControllerDelegate>
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    
    
   
    
    [XGPush startApp:kXingePush_ACCESSID appKey:kXingePush_ACCESSKEY];
    
    [XGPush handleLaunching:launchOptions];

    
    
    
    //设置navigationbar
    [[UINavigationBar appearance] setTintColor:kNavigationTintColor];
    [[UINavigationBar appearance ] setBarTintColor:kNavigationBarColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [[UITabBar appearance] setTintColor:kNavigationBarColor];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:kBaiduMapKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    

    
    
    //注册推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        

        
       
    } else {
        
          [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];

    }
    
    
    
    
    
  BOOL unregist =   [XGPush isUnRegisterStatus];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin]) {
        
        
        [XGPush setAccount:[NSString stringWithFormat:@"%@",[UserInfo getUserModel].mobile]];

        NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
        
        if (deviceToken) {
            
            
            [XGPush registerDevice:deviceToken successCallback:^{
                
                //成功之后的处理
                NSLog(@"[XGPush Demo]register successBlock");
                
                
            } errorCallback:^{
                //失败之后的处理
                NSLog(@"[XGPush Demo]register errorBlock");
            }];
            
            
        }
        
        
    }
    
    NSLog(@"isUnregist:%d",unregist);
    
    NSLog( @"%d" ,[UIApplication sharedApplication].isRegisteredForRemoteNotifications);
    
    
      application.applicationIconBadgeNumber = 0;
  
    
    NSString *ip = [GetIPAddress newIpAddress];
    
    NSLog(@"ip:%@",ip);
    
    
    return YES;
 }


#ifdef __IPHONE_8_0

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    
}
#endif




-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    
    
    [[NSUserDefaults standardUserDefaults ] setObject:deviceToken forKey:kDeviceToken];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    NSLog(@"xingge appid:%d",[XGPush getAccessID]);
    

    
    
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"fail remote push error:%@",error);
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"did receiveRemoteNotification:%@",userInfo);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRecevieNewOrderNoti object:nil];
    
    
    
    [XGPush handleReceiveNotification:userInfo];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    application.applicationIconBadgeNumber = 0;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return   interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    
    

}



- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}



@end
