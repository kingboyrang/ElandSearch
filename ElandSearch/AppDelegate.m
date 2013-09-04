//
//  AppDelegate.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UserSet.h"
#import "SecrecyViewController.h"
#import "MainViewController.h"
@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //[asyncHelper asyncCircularTypes];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    UserSet *user=[UserSet loadUser];
    if (user.isSecondLoad==NO) {
        user.isSecondLoad=YES;
        user.isFirstLoad=YES;
    }
    if (user.isFirstLoad) {
        user.isFirstLoad=NO;
        [UserSet save:user];
        SecrecyViewController *privacy=[[SecrecyViewController alloc] init];
        privacy.title=@"隱私及資訊安全保護政策";
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:privacy];
         self.window.rootViewController = nav;
        [privacy release];
        [nav release];
        [self startLoading];
    }else{
        MainViewController *main=[[[MainViewController alloc] init] autorelease];
        self.window.rootViewController = main;
    }
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor colorWithRed:104/255.0 green:171/255.0 blue:4/255.0 alpha:1.0]];
    [self.window makeKeyAndVisible];
    return YES;
}
//第一次启动时加载动画
-(void)startLoading{
    CGRect rect=[[UIScreen mainScreen] bounds];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:rect];
    [imageView setImage:[UIImage imageNamed:@"load.jpg"]];
    imageView.tag=100;
    [self.window addSubview:imageView];
    [imageView release];
    
    MBProgressHUD *HUD = [[[MBProgressHUD alloc] initWithWindow:self.window] autorelease];
    HUD.tag=101;
    [self.window addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    //HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}
//动画效果
- (void)myProgressTask {
    UIImageView *imageView=(UIImageView*)[self.window viewWithTag:100];
    MBProgressHUD *hud=(MBProgressHUD*)[self.window viewWithTag:101];
	// This just increases the progress indicator in a loop
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		hud.progress = progress;
		usleep(30000);//1s=1000(毫秒)=1000000(微秒)
	}
    [hud removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        imageView.alpha=0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
    //self.window.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
