//
//  HRPopoverViewController.m
//  ElandSearch
//
//  Created by rang on 13-8-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRPopoverViewController.h"

@interface HRPopoverViewController ()

@end

@implementation HRPopoverViewController
@synthesize listData=_listData;
@synthesize delegate;
@synthesize popover;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    cell.textLabel.text=[self.listData objectAtIndex:indexPath.row];
    cell.accessoryType=currentIndex==indexPath.row?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    // Configure the cell...
    
    return cell;
}
#pragma mark - Table view delegate
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
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishItemSelected:value:)]) {
        SEL addMethod = NSSelectorFromString(@"finishItemSelected:value:");
        [self.delegate performSelector:addMethod withObject:popover withObject:[self.listData objectAtIndex:currentIndex]];
        //[self.delegate performSelector:addMethod withObject:[self.listData objectAtIndex:currentIndex]];
    }
}


@end
