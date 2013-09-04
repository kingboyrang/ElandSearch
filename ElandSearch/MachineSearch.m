//
//  MachineSearch.m
//  ElandSearch
//
//  Created by rang on 13-8-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MachineSearch.h"
#import "UserSet.h"
@interface MachineSearch ()
-(void)loadSourceData;
@end

@implementation MachineSearch
-(void)dealloc{
    [super dealloc];
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
    
    
    //self.view.backgroundColor=[UIColor colorFromHexRGB:@"caf593"];
    
    args=[[VCircularSearchArgs alloc] init];
    args.CurPage=0;
    args.CurSize=20;
    
    _pageCount=1;
    _curPage=0;
    _isFirst=YES;
    
    //第1次加载执时[下拉加载]
    [self.tableView launchRefreshing];//默认加载10笔数据
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
    UserSet *user=[UserSet loadUser];
    if ([user.Flag length]>0) {
        args.Flag=user.Flag;
    }
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
    /**
    if (![NetWorkConnection connectedToNetwork]){
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"網絡連接失敗!"];
        self.tableView.reachedTheEnd  = NO;
        return;
    }
      **/
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
@end
