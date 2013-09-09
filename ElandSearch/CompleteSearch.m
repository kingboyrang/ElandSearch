//
//  CompleteSearch.m
//  ElandSearch
//
//  Created by rang on 13-8-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CompleteSearch.h"

@interface CompleteSearch ()
-(void)loadSourceData;
-(void)reloadSearchArgs;
@end

@implementation CompleteSearch
-(void)dealloc{
    [super dealloc];
    [_searchView release],_searchView=nil;
    [args release],args=nil;
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
    
     _searchView=[[SearchView alloc] initWithFrame:CGRectMake(5,5, self.view.bounds.size.width-10, 373)];
    _searchView.croller=self;
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(buttonSearchClick)];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];
    
    args=[[VCircularSearchArgs alloc] init];
        
    //第1次加载执时[下拉加载]
    [self startSearch];
	// Do any additional setup after loading the view.
}
-(void)buttonSearchClick{
    [_searchView show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateSourceData:(NSArray*)source{
    if (!source) {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"沒有返回數據!"];
        self.tableView.reachedTheEnd  = NO;
        args.CurPage--;
        return;
    }
    if (_isFirst) {
        _isFirst=NO;
        self.sourceData=[NSMutableArray arrayWithArray:source];
        [self.tableView reloadData];
    }else{
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<[source count]; i++) {
            [self.sourceData addObject:[source objectAtIndex:i]];
            NSIndexPath *newPath=[NSIndexPath indexPathForRow:(args.CurPage-1)*args.CurSize+i inSection:0];
            [insertIndexPaths addObject:newPath];
        }
        //重新呼叫UITableView的方法, 來生成行.
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
}
-(void)loadSourceData{
    [self reloadSearchArgs];
    NSString *soapMsg=[args ObjectSeriationToString];
    NSArray *params=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:soapMsg,@"xml", nil], nil];
    ServiceArgs *_args=[[[ServiceArgs alloc] init] autorelease];
    _args.methodName=@"SearchCircular";
    _args.soapParams=params;
    [ServiceHelper asynService:_args completed:^(ServiceResult *result) {
        
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        
        NSString *page;
        NSArray *arr=[VCircular xmlToVCircular:result page:&page];
        _pageCount=[page intValue];
        [self performSelectorOnMainThread:@selector(updateSourceData:) withObject:arr waitUntilDone:NO];
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"沒有返回數據!"];
        self.tableView.reachedTheEnd  = NO;
        args.CurPage--;
    }];
}
-(void)loadData{
    if (self.refreshing) {
        self.refreshing=NO;
    }
    if (!self.hasNetwork) {
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        [self showNoNetworkErrorView];
        return;
    }
    if (args.CurPage!=_pageCount) {
        args.CurPage++;
        if (args.CurPage>=_pageCount) {
            args.CurPage=_pageCount;
        }
        [self loadSourceData];//加载数据
    }else{
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"下面没有了.."];
        self.tableView.reachedTheEnd  = YES;
        
    }
    
}
-(void)viewCaseDetail:(VCircular*)entity{
    
}
//开始查询
-(void)startSearch{
    args.CurPage=0;
    args.CurSize=20;
    _pageCount=1;
    _curPage=0;
    _isFirst=YES;
    //第1次加载执时[下拉加载]
    [self.tableView launchRefreshing];//默认加载10笔数据
}
#pragma mark 私有方法
-(void)reloadSearchArgs{
    NSDictionary *dic=[_searchView caseSearchArgs];
    args.Category=[dic objectForKey:@"Category"];
    args.Ctiy=[dic objectForKey:@"Ctiy"];
    args.SDate=[dic objectForKey:@"SDate"];
    args.EDate=[dic objectForKey:@"EDate"];
    args.Number=[dic objectForKey:@"Number"];
}
@end
