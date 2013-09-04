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
-(void)saveImage:(UIImage*)image withName:(NSString*)name;
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
    
    //UIImage *image=[[UIImage imageNamed:@"arrow_down@2x.png"] imageRotatedByDegrees:-90];
    //[self saveImage:image withName:@"arrow_down@2x.png"];
}
-(void)saveImage:(UIImage*)image withName:(NSString*)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
    NSLog(@"result=%c\n",result);
    NSLog(@"path=%@\n",filePath);
}
-(void)loadControls{
    NSDictionary* textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor],UITextAttributeTextColor,
                                    [UIFont boldSystemFontOfSize:11],UITextAttributeFont,
                                    [UIColor grayColor],UITextAttributeTextShadowColor,
                                    [NSValue valueWithCGSize:CGSizeMake(1, 1)],UITextAttributeTextShadowOffset,
                                    nil];
    
    //110,178,5
    IndexViewController *index=[[[IndexViewController alloc] init] autorelease];
    [index.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [index.tabBarItem setTitle:@"首頁"];
    [index.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"index_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"index_normal.png"]];
    UINavigationController *nav1=[[[UINavigationController alloc] initWithRootViewController:index] autorelease];
    
    
    UserSetViewController *userSet=[[[UserSetViewController alloc] init] autorelease];
    userSet.title=@"使用者設定";
    [userSet.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [userSet.tabBarItem setTitle:@"使用者設定"];
    [userSet.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"user_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"user_normal.png"]];
    UINavigationController *nav2=[[[UINavigationController alloc] initWithRootViewController:userSet] autorelease];
    
    aboutUSViewController *aboutUS=[[[aboutUSViewController alloc] init] autorelease];
    aboutUS.title=@"關於我";
    [aboutUS.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [aboutUS.tabBarItem setTitle:@"關於我"];
    [aboutUS.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"about_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"about_normal.png"]];
    UINavigationController *nav3=[[[UINavigationController alloc] initWithRootViewController:aboutUS] autorelease];
    [self setViewControllers:[NSArray arrayWithObjects:nav1,nav2,nav3, nil]];
    
    // NSLog(@"rect=%@\n",NSStringFromCGRect(self.tabBar.bounds));
    
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

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
