//
//  MainViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MainViewController.h"
#import "IndexViewController.h"
#import "aboutUSViewController.h"
#import "UserSetViewController.h"

@interface MainViewController ()
-(void)loadControls;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadControls];

}
-(void)loadControls{
    NSDictionary* textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor],UITextAttributeTextColor,
                                    [UIFont boldSystemFontOfSize:11],UITextAttributeFont,
                                    [UIColor grayColor],UITextAttributeTextShadowColor,
                                    [NSValue valueWithCGSize:CGSizeMake(1, 1)],UITextAttributeTextShadowOffset,
                                    nil];
    
    //110,178,5
    UITabBarItem *barItem1=[[[UITabBarItem alloc] init] autorelease];
    [barItem1 setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    barItem1.title=@"首頁";
    barItem1.tag=0;
    [barItem1 setFinishedSelectedImage:[UIImage imageNamed:@"first_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"first_normal.png"]];
    IndexViewController *indexController=[[[IndexViewController alloc] init] autorelease];
    indexController.tabBarItem=barItem1;
    UINavigationController *nav1=[[[UINavigationController alloc] initWithRootViewController:indexController] autorelease];
   
    
    
    UITabBarItem *barItem2=[[[UITabBarItem alloc] init] autorelease];
    [barItem2 setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    barItem2.title=@"使用者設定";
    barItem2.tag=1;
    [barItem2 setFinishedSelectedImage:[UIImage imageNamed:@"user_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"user_normal.png"]];
    UserSetViewController *userSet=[[[UserSetViewController alloc] init] autorelease];
    userSet.title=@"使用者設定";
    userSet.tabBarItem=barItem2;
    UINavigationController *nav2=[[[UINavigationController alloc] initWithRootViewController:userSet] autorelease];
    
    
   

    
    
    UITabBarItem *barItem3=[[[UITabBarItem alloc] init] autorelease];
    [barItem3 setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    barItem3.title=@"關於我";
    barItem3.tag=2;
    [barItem3 setFinishedSelectedImage:[UIImage imageNamed:@"about_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"about_normal.png"]];
    aboutUSViewController *aboutUS=[[[aboutUSViewController alloc] init] autorelease];
    aboutUS.title=@"關於我";
    aboutUS.tabBarItem=barItem3;
    UINavigationController *nav3=[[[UINavigationController alloc] initWithRootViewController:aboutUS] autorelease];
   
    
    
    
    UIView *bgView=[[[UIView alloc] initWithFrame:self.tabBar.bounds] autorelease];
    UIImageView *tabBarBgView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    [tabBarBgView setImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    [tabBarBgView setContentMode:UIViewContentModeScaleToFill];
    [tabBarBgView setAutoresizesSubviews:YES];
    [tabBarBgView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [bgView addSubview:tabBarBgView];
    [bgView setAutoresizesSubviews:YES];
    [bgView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.tabBar insertSubview:bgView atIndex:1];
    self.tabBar.opaque=YES;
    [tabBarBgView release];
    
     [self setViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3, nil]];
    self.selectedIndex=0;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
