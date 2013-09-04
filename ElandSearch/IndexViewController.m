//
//  IndexViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "IndexViewController.h"
#import "TPMenuCell.h"
@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize tableView=_tableView;
@synthesize listData=_listData;
-(void)dealloc{
    [_tableView release];
    [_listData release];
    [super dealloc];
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
    UIImage *img=[UIImage imageNamed:@"logo.png"];
    CGFloat leftx=(self.view.bounds.size.width-img.size.width)/2.0;
    UIImageView *logoView=[[UIImageView alloc] initWithImage:img];
    logoView.frame=CGRectMake(leftx, 0, img.size.width, img.size.height);
    [logoView setAutoresizesSubviews:YES];
    [logoView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    self.navigationItem.titleView=logoView;
    [logoView release];
    
    CGRect rect=self.view.bounds;
    
    _tableView=[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    _listData=[[NSArray alloc] initWithContentsOfFile:path];

	// Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //[_tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg.png"]]];
    return [_listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    TPMenuCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[TPMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
   NSDictionary *dic=[_listData objectAtIndex:indexPath.row];
   NSString *key=[[dic allKeys] objectAtIndex:0];
    cell.textLabel.text=[dic objectForKey:key];
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];//Verdana  Helvetica-Bold
    cell.textLabel.textColor= [UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.detailTextLabel.backgroundColor=[UIColor clearColor];
    //242,238,226
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=[_listData objectAtIndex:indexPath.row];
     NSString *key=[[dic allKeys] objectAtIndex:0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id viewController=[[NSClassFromString(key) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
