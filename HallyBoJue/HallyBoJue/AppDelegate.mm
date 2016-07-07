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
        
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"action";//按钮的标示
        action.title=@"Accept";//按钮的标题
        action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        //    action.authenticationRequired = YES;
        //    action.destructive = YES;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";//这组动作的唯一标示
        [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
        
        
         NSSet *categories = [NSSet setWithObjects:categorys, nil];
        
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:categories];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        

        
       
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

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"did receiveRemoteNotification:%@",userInfo);
    
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
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
