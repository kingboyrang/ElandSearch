//
//  ApplyItemViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ApplyItemViewController.h"
#import "HRViewController.h"
@interface ApplyItemViewController ()

@end

@implementation ApplyItemViewController

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
    self.title=@"申辦事項說明";
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"ApplyItem" ofType:@"txt"];
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
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"確認" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClick)];
    
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];

	// Do any additional setup after loading the view.
}
-(void)buttonClick{
    HRViewController *hr=[[HRViewController alloc] init];
    [self.navigationController pushViewController:hr animated:YES];
    [hr release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
