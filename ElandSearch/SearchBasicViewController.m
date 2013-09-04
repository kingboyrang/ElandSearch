//
//  SearchBasicViewController.m
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchBasicViewController.h"
#import "TPSearchCell.h"
#import "ShakingAlertView.h"
#import "AlterMessage.h"
@interface SearchBasicViewController ()
-(void)showFailedPasswordAlert:(VCircular*)entity failure:(void (^)(void))failed;
@end

@implementation SearchBasicViewController
@synthesize tableView=_tableView;
@synthesize sourceData=_sourceData;
@synthesize refreshing;
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_sourceData release],_sourceData=nil;
}
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
    self.view.backgroundColor=[UIColor colorWithRed:243/255.0 green:239/255.0 blue:228/255.0 alpha:1.0];
    
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:self.view.bounds pullingDelegate:self];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setAutoresizesSubviews:YES];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetNavigationBarBack{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"back";
    self.navigationItem.backBarButtonItem = backItem;
    [backItem release];
}
-(void)showAlterViewPassword:(VCircular*)entity success:(void (^)(void))completed{
    ShakingAlertView *alter=[[ShakingAlertView alloc] initWithAlertTitle:@"案件密碼"
                                                        checkForPassword:entity.PWD
                                                       onCorrectPassword:^{
                                                           if (completed) {
                                                               completed();
                                                           }
                                                       }
                                              onDismissalWithoutPassword:^{
                                                  [self showFailedPasswordAlert:entity failure:completed];
                                              }];
    [alter show];
    [alter release];
}
-(void)showFailedPasswordAlert:(VCircular*)entity failure:(void (^)(void))failed{
    [AlterMessage showConfirmAndCancel:@"Failed Password Entry" withMessage:@"To access the password protected view you must enter a valid password. Try again?" cancelMessage:@"No" confirmMessage:@"Yes" cancelAction:nil confirmAction:^{
        [self showAlterViewPassword:entity success:failed];
    }];
}
#pragma mark - PullingRefreshTableViewDelegate
//下拉加载
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

//上拉加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.sourceData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCircularIdentifier";
    TPSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[TPSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    VCircular *entity=[self.sourceData objectAtIndex:indexPath.row];
    [cell setDataSource:entity];
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TPSearchCell *cell=(TPSearchCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell selectedCellAnimal:^{
        VCircular *entity=(VCircular*)[self.sourceData objectAtIndex:indexPath.row];
        [self showAlterViewPassword:entity success:^{
            //表示成功了
            [self viewCaseDetail:entity];
        }];
    }];
}
-(void)viewCaseDetail:(VCircular*)entity{

}
-(void)loadData{
}
@end
