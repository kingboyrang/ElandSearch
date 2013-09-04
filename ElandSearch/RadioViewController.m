//
//  RadioViewController.m
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "RadioViewController.h"

@interface RadioViewController ()

@end

@implementation RadioViewController
@synthesize listData=_listData;
@synthesize delegate;
-(void)dealloc{
    [_listData release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentIndex=-1;
    self.title=@"案件類別";
    NSMutableArray *funArr=[NSMutableArray array];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"key",@"",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"路平報修",@"key",@"A",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"路燈報修",@"key",@"B",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"環保查報",@"key",@"C",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"寵物協尋",@"key",@"D",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"稅務預約",@"key",@"E",@"value", nil]];
    [funArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶政預約",@"key",@"F",@"value", nil]];
    
    self.listData=funArr;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSDictionary *dic=[self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"key"];
    cell.accessoryType=currentIndex==indexPath.row?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    // Configure the cell...
    
    return cell;
}
#pragma mark - Table view delegate
/***
 - (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
 {
 if(indexPath.row==currentIndex){
 return UITableViewCellAccessoryCheckmark;
 }
 else{
 return UITableViewCellAccessoryNone;
 }
 }
 ***/
- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int newRow=indexPath.row;
    if(newRow!=currentIndex){
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (currentIndex!=-1) {
            NSIndexPath *oldIndexPath=[NSIndexPath indexPathForItem:currentIndex inSection:0];
            UITableViewCell *oldCell=[tableView cellForRowAtIndexPath:oldIndexPath];
            oldCell.accessoryType=UITableViewCellAccessoryNone;
        }
        currentIndex=newRow;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedTableRowVillage:)]) {
        SEL addMethod = NSSelectorFromString(@"selectedCategory:");
        NSDictionary *dic=[self.listData objectAtIndex:indexPath.row];
        [self.delegate performSelector:addMethod withObject:dic];
        //[self.delegate selectedTableRowVillage:[self.listData objectAtIndex:currentIndex]];
    }
}
@end
