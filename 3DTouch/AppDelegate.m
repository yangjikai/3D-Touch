//
//  AppDelegate.m
//  3DTouch
//
//  Created by vcube on 16/11/29.
//  Copyright © 2016年 vcube. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PressureViewController.h"
#import "DirectViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController * home = [[ViewController alloc] init];
    UINavigationController * na = [[UINavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = na;
    [self.window makeKeyAndVisible];
    
    
    //创建应用图标上的3D touch快捷选项
    [self createShortcutItems];
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    if (shortcutItem) {
        //判断先前设定的快捷选项标签的唯一标识符，根据不同的标识符执行不同的操作
        if ([shortcutItem.type isEqualToString:@"com.myApp.touch"]) {
            NSArray *arr = @[@"hello 3D Touch"];
            UIActivityViewController *VC = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
            [self.window.rootViewController presentViewController:VC animated:YES completion:nil];
            
        } else if ([shortcutItem.type isEqualToString:@"com.PressureTest.touch"]) {
            PressureViewController *pressure = [[PressureViewController alloc]init];
            [na pushViewController:pressure animated:YES];
            
        } else if ([shortcutItem.type isEqualToString:@"com.specified.touch"]) {
            DirectViewController *direct = [[DirectViewController alloc]init];
            [na pushViewController:direct animated:YES];
        }
        return NO;
    }
    return YES;
}

-(void)createShortcutItems{
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    //自定义图标的icon
//    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"shar.png"];
    
    
    //创建快捷选项
//    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:@"com.myshare.share" localizedTitle:@"分享"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"com.myApp.touch" localizedTitle:@"分享" localizedSubtitle:@"副标题" icon:icon userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"com.PressureTest.touch" localizedTitle:@"压力测试" localizedSubtitle:nil icon:icon2 userInfo:nil];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc]initWithType:@"com.specified.touch" localizedTitle:@"指定页面" localizedSubtitle:nil icon:icon3 userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3];
    
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController * home = [[ViewController alloc] init];
    UINavigationController * na = [[UINavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = na;
    [self.window makeKeyAndVisible];
    
    if (shortcutItem) {
        
        if ([shortcutItem.type isEqualToString:@"com.myApp.touch"]) { //进入首页
            
            NSArray *arr = @[@"hello 3D Touch"];
            UIActivityViewController *VC = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
            [self.window.rootViewController presentViewController:VC animated:YES completion:nil];

        } else if ([shortcutItem.type isEqualToString:@"com.PressureTest.touch"]) { // 进入压力测试
            
            PressureViewController *pressure = [[PressureViewController alloc]init];
            [na pushViewController:pressure animated:YES];
            
        } else if ([shortcutItem.type isEqualToString:@"com.specified.touch"]) { // 进入指定页面
            
            DirectViewController *direct = [[DirectViewController alloc]init];
            [na pushViewController:direct animated:YES];
        }
        
        if (completionHandler) {
            completionHandler(YES);
        }
        
    }
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
