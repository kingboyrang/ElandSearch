//
//  secrecy 	 secrecy 	 secrecy 	 secrecy SecrecyViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-26.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SecrecyViewController.h"
#import "MainViewController.h"
#import "UserSetViewController.h"
#import "UserSet.h"
#import "MBProgressHUD.h"
@interface SecrecyViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
-(void)startLoading;
- (void)myProgressTask;
@end

@implementation SecrecyViewController

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
    
    UserSet *user=[UserSet loadUser];
    if (user.isFirstLoad) {
        //self.navigationController.view.alpha=0.0;
        [self startLoading];
    }
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Privacy" ofType:@"txt"];
    NSString *content=[[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] autorelease];
    
    
    CGFloat h=self.view.bounds.size.height;
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,h)];
    textView.backgroundColor=[UIColor clearColor];
    textView.text=content;
    textView.editable=NO;
    [textView setFont:[UIFont fontWithName:@"Verdana" size:13]];
    textView.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    [textView setAutoresizesSubviews:YES];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    [self.view addSubview:textView];
    [textView release];
    
    
    //NSArray *views=self.navigationController.viewControllers;
   if (user.isFirstLoad) {
        UIImage *img=[UIImage imageNamed:@"logo2.png"];
        CGFloat leftx=(self.view.bounds.size.width-img.size.width)/2.0;
        UIImageView *logoView=[[UIImageView alloc] initWithImage:img];
        logoView.frame=CGRectMake(leftx, 0, img.size.width, img.size.height);
        [logoView setAutoresizesSubviews:YES];
        [logoView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.navigationItem.titleView=logoView;
        [logoView release];
        
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"確認" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClick)];
        
        self.navigationItem.rightBarButtonItem=rightBtn;
        [rightBtn release];

    }
    // Do any additional setup after loading the view.
}
-(void)buttonClick{
    MainViewController *main=[[MainViewController alloc] init];
    main.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:main animated:YES completion:nil];
    [main release];
}
//第一次启动时加载动画
-(void)startLoading{
    
    CGRect rect=[[UIScreen mainScreen] bounds];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:rect];
    [imageView setImage:[UIImage imageNamed:@"load.jpg"]];
    imageView.tag=100;
    [self.navigationController.view addSubview:imageView];
    [imageView release];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}
//动画效果
- (void)myProgressTask {
    
    UIImageView *imageView=(UIImageView*)[self.navigationController.view viewWithTag:100];
	// This just increases the progress indicator in a loop
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(30000);//1s=1000(毫秒)=1000000(微秒)
	}
    [UIView animateWithDuration:0.5f animations:^{
        imageView.alpha=0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
         UserSet *user=[UserSet loadUser];
         user.isFirstLoad=NO;
         [UserSet save:user];
    }];
    
    //self.window.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
}
- (void)hudWasHidden:(MBProgressHUD *)hud{
    [HUD removeFromSuperview];
    [HUD release];
    HUD=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
