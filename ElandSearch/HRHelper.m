//
//  HRHelper.m
//  ElandSearch
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "HRHelper.h"
#import "TKEmptyCell.h"
#import "TKTextViewCell.h"
#import "TKLabelCell.h"
#import "TKLabelTextViewCell.h"
#import "ApplyItemsViewController.h"
#import "HRPopoverViewController.h"
@implementation HRHelper
@synthesize itemName;
@synthesize startIndex;
@synthesize endIndex;
@synthesize cellHeights;
@synthesize dataSource;

-(void)dealloc{
    [super dealloc];
    if (popoverRelative) {
        [popoverRelative release],popoverRelative=nil;
    }
    if (popoverItem) {
        [popoverItem release],popoverItem=nil;
    }
    if (popoverTings) {
        [popoverTings release],popoverTings=nil;
    }
    if (popoverDieRelative) {
        [popoverDieRelative release],popoverDieRelative=nil;
    }
}

-(id)init{
    if (self=[super init]) {
        self.itemName=@"出生登記";
            NSMutableArray *arr=[[[NSMutableArray alloc] initWithObjects:[self applyItemCell], nil] autorelease];
            NSMutableArray *heights=[[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:44], nil] autorelease];
            NSDictionary *birthDic=[self HRBirth];
            [arr addObjectsFromArray:[birthDic objectForKey:@"birth"]];
            [heights addObjectsFromArray:[birthDic objectForKey:@"brithHeights"]];
            
            NSDictionary *dic=[self HRContact];
            [arr addObjectsFromArray:[dic objectForKey:@"contact"]];
            [heights addObjectsFromArray:[dic objectForKey:@"contactHeights"]];
            cellHeights=[heights retain];
            dataSource=[arr retain];
            startIndex=1;
            endIndex=5;
    }
    return self;
}

-(void)buttonChangeItem{
    UITableViewCell *sender=(UITableViewCell*)[dataSource objectAtIndex:0];
    if (!popoverItem) {
        ApplyItemsViewController *controller=[[[ApplyItemsViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        popoverItem = [[FPPopoverController alloc] initWithViewController:controller];
        popoverItem.tint=FPPopoverLightGrayTint;
        popoverItem.contentSize = CGSizeMake(200, 300);
        popoverItem.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverItem presentPopoverFromView:sender];
}
-(void)selectedTableRowItem:(NSString*)item{
    
    TKLabelTextFieldCell *cell=(TKLabelTextFieldCell*)[self.dataSource objectAtIndex:0];
    cell.field.text=item;
    [popoverItem dismissPopoverAnimated:YES];
    [popoverItem dismissPopoverAnimated:YES completion:^{
        self.itemName=item;
    }];
    
}
-(void)removeDataSourceItem{
    int len=self.endIndex-self.startIndex+1;
    [dataSource removeObjectsInRange:NSMakeRange(self.startIndex,len)];
    [cellHeights removeObjectsInRange:NSMakeRange(self.startIndex, len)];
}
-(void)insertDataSourceItem:(NSString*)name{
    if ([name isEqualToString:@"出生登記"]) {
        endIndex=5;
        NSDictionary *dic=[self HRBirth];
        [dataSource insertObjects:[dic objectForKey:@"birth"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 5)]];
        [cellHeights insertObjects:[dic objectForKey:@"brithHeights"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 5)]];
    }
    if ([name isEqualToString:@"結婚登記"]) {
        endIndex=10;
        NSDictionary *dic=[self HRMarry];
        [dataSource insertObjects:[dic objectForKey:@"marry"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 10)]];
        [cellHeights insertObjects:[dic objectForKey:@"marryHeights"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 10)]];
    }
    if ([name isEqualToString:@"死亡登記"]) {
        endIndex=9;
        NSDictionary *dic=[self HRDie];
        [dataSource insertObjects:[dic objectForKey:@"die"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 9)]];
        [cellHeights insertObjects:[dic objectForKey:@"dieHeights"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 9)]];
    }
}
-(void)buttonDieRelativeTap{
    UITableViewCell *cell=(UITableViewCell*)[dataSource objectAtIndex:3];
    if(!popoverDieRelative){
        HRPopoverViewController *controller=[[[HRPopoverViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        controller.title=@"申請人與往生者之關係";
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Deceased" ofType:@"plist"];
        controller.listData=[NSArray arrayWithContentsOfFile:path];
        popoverDieRelative = [[FPPopoverController alloc] initWithViewController:controller];
        popoverDieRelative.tint=FPPopoverLightGrayTint;
        popoverDieRelative.contentSize = CGSizeMake(200, 300);
        popoverDieRelative.arrowDirection = FPPopoverArrowDirectionAny;
        controller.popover=popoverDieRelative;

    }
     [popoverDieRelative presentPopoverFromView:cell];
}
-(void)buttonTingsTap{
    UITableViewCell *sender=nil;
    if ([self.itemName isEqualToString:@"出生登記"]) {
        sender=(UITableViewCell*)[dataSource objectAtIndex:5];
    }
    if ([self.itemName isEqualToString:@"死亡登記"]) {
        sender=(UITableViewCell*)[dataSource objectAtIndex:9];
    }
    if ([self.itemName isEqualToString:@"結婚登記"]) {
        sender=(UITableViewCell*)[dataSource objectAtIndex:3];
    }
    if (!popoverTings) {
        HRPopoverViewController *controller=[[[HRPopoverViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.delegate=self;
        NSString *path=[[NSBundle mainBundle] pathForResource:@"things" ofType:@"plist"];
        controller.listData=[NSArray arrayWithContentsOfFile:path];
        popoverTings = [[FPPopoverController alloc] initWithViewController:controller];
        popoverTings.tint=FPPopoverLightGrayTint;
        popoverTings.contentSize = CGSizeMake(200, 300);
        popoverTings.arrowDirection = FPPopoverArrowDirectionAny;
        controller.popover=popoverTings;
    }
    [popoverTings presentPopoverFromView:sender];
}
-(void)buttonRelativeTap{
     TKTextFieldCell *sender=(TKTextFieldCell*)[dataSource objectAtIndex:3];
    //出生登記 2
    if (!popoverRelative) {
        HRPopoverViewController *controller=[[[HRPopoverViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        controller.title=@"申請人與新生兒之關係";
        controller.delegate=self;
        NSString *path=[[NSBundle mainBundle] pathForResource:@"relative" ofType:@"plist"];
        controller.listData=[NSArray arrayWithContentsOfFile:path];
        popoverRelative = [[FPPopoverController alloc] initWithViewController:controller];
        popoverRelative.tint=FPPopoverLightGrayTint;
        popoverRelative.contentSize = CGSizeMake(200, 300);
        popoverRelative.arrowDirection = FPPopoverArrowDirectionAny;
        controller.popover=popoverRelative;
    }
    [popoverRelative presentPopoverFromView:sender];
}
-(void)finishItemSelected:(FPPopoverController*)sender value:(NSString*)name{
    if (popoverRelative==sender){
        TKTextFieldCell *cell=(TKTextFieldCell*)[dataSource objectAtIndex:3];
        cell.field.text=name;
        [popoverRelative dismissPopoverAnimated:YES];
    }
    if (popoverTings==sender) {
        TKTextFieldCell *cell=nil;
        if ([self.itemName isEqualToString:@"出生登記"]) {
            cell=(TKTextFieldCell*)[dataSource objectAtIndex:5];
        }
        if ([self.itemName isEqualToString:@"死亡登記"]) {
            cell=(TKTextFieldCell*)[dataSource objectAtIndex:9];
        }
        if ([self.itemName isEqualToString:@"結婚登記"]) {
            cell=(TKTextFieldCell*)[dataSource objectAtIndex:3];
        }
        if (cell) {
            cell.field.text=name;
        }
         [popoverTings dismissPopoverAnimated:YES];
    }
    if (sender==popoverDieRelative) {
        TKTextFieldCell *cell=(TKTextFieldCell*)[dataSource objectAtIndex:3];
        cell.field.text=name;
        [popoverDieRelative dismissPopoverAnimated:YES];
    }
}

-(TKLabelTextFieldCell*)applyItemCell{
    TKLabelTextFieldCell *cell1=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.label.componentsAndPlainText=[cell1 labelName:@"申辦項目:" required:YES];
    cell1.field.placeholder=@"editable item";
    cell1.field.text=@"出生登記";
    cell1.field.enabled=NO;
    return cell1;
}
-(NSDictionary*)HRBirth{
    TKEmptyCell *cell1=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell1.textLabel.numberOfLines=0;
    cell1.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Birth" ofType:@"txt"];
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    cell1.textLabel.text=content;
    //140高度
    
    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell2.textLabel.text=@"申請人與新生兒之關係:";
    cell2.textLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    
    TKTextFieldCell *cell3=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.field.placeholder=@"editable relative";
    cell3.field.enabled=NO;
    
    TKEmptyCell *cell4=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell4.textLabel.text=@"新生兒預約設籍之戶政事務所:";
    cell4.textLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    
    TKTextFieldCell *cell5=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.field.placeholder=@"editable relative";
    cell5.field.enabled=NO;
    
    NSArray *arr=[NSArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5, nil];
    NSArray *heights=[NSArray arrayWithObjects:[NSNumber numberWithFloat:140],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44], nil];
    return [NSDictionary dictionaryWithObjectsAndKeys:arr,@"birth",heights,@"brithHeights", nil];
    
}
-(NSDictionary*)HRDie{
    TKEmptyCell *cell1=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell1.textLabel.numberOfLines=0;
    cell1.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Die" ofType:@"txt"];
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    cell1.textLabel.text=content;
    //140高度
    
    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell2.textLabel.text=@"申請人與往生者之關係:";
    
    TKTextFieldCell *cell3=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.field.placeholder=@"editable relative";
    cell3.field.enabled=NO;
    
    TKEmptyCell *cell4=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell4.textLabel.text=@"往生者姓名:";
    
    TKTextFieldCell *cell5=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.field.placeholder=@"editable name";
    cell5.field.enabled=NO;
    
    TKEmptyCell *cell6=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell6.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell6.textLabel.text=@"往生者戶籍地址:";

    TKTextViewCell *cell7=[[[TKTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell7.textView.placeholder=@"editable name";
    //120高度
    
    TKEmptyCell *cell8=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell8.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell8.textLabel.text=@"預約戶籍地戶政事務所:";
    
    
    TKTextFieldCell *cell9=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell9.field.placeholder=@"editable relative";
    cell9.field.enabled=NO;
    
    NSArray *arr=[NSArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9, nil];
    NSArray *heights=[NSArray arrayWithObjects:[NSNumber numberWithFloat:140],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:120],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44], nil];
    return [NSDictionary dictionaryWithObjectsAndKeys:arr,@"die",heights,@"dieHeights", nil];
}
-(NSDictionary*)HRMarry{
    TKEmptyCell *cell1=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell1.textLabel.numberOfLines=0;
    cell1.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Marry" ofType:@"txt"];
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    cell1.textLabel.text=content;
    
    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell2.textLabel.text=@"預約戶籍地之戶政事務所:";
    
    TKTextFieldCell *cell3=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.field.placeholder=@"editable relative";
    cell3.field.enabled=NO;
    
    TKEmptyCell *cell4=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell4.textLabel.text=@"結婚當事人基本資料:";
    
    TKLabelCell *cell5=[[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.label.componentsAndPlainText=[cell5 labelName:@"姓名:" required:YES];
    
    TKLabelTextFieldCell *cell6=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell6.label.componentsAndPlainText=[cell6 labelName:@"男:" required:NO];
    cell6.field.placeholder=@"editable boyname";
    
    TKLabelTextFieldCell *cell7=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell7.label.componentsAndPlainText=[cell7 labelName:@"女:" required:NO];
    cell7.field.placeholder=@"editable girlname";
    
    TKLabelCell *cell8=[[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell8.label.componentsAndPlainText=[cell8 labelName:@"戶籍地址:" required:YES];
    
    TKLabelTextViewCell *cell9=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell9.label.componentsAndPlainText=[cell9 labelName:@"男:" required:NO];
    cell9.textView.font=[UIFont boldSystemFontOfSize:16];
    cell9.textView.placeholder=@"editable address";
    
    TKLabelTextViewCell *cell10=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell10.label.componentsAndPlainText=[cell10 labelName:@"女:" required:NO];
    cell10.textView.font=[UIFont boldSystemFontOfSize:16];
    cell10.textView.placeholder=@"editable address";
    
    NSArray *arr=[NSArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10, nil];
    NSArray *heights=[NSArray arrayWithObjects:[NSNumber numberWithFloat:120],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:120],[NSNumber numberWithFloat:120], nil];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:arr,@"marry",heights,@"marryHeights", nil];
}
-(NSDictionary*)HRContact{
    TKEmptyCell *cell1=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    cell1.textLabel.text=@"申請人聯絡方式:";
    cell1.textLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    
    TKLabelTextFieldCell *cell2=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.componentsAndPlainText=[cell2 labelName:@"申請人姓名:" required:YES];
    cell2.field.placeholder=@"editable name";
    
    TKLabelTextViewCell *cell3=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.componentsAndPlainText=[cell3 labelName:@"申請人地址:" required:YES];
    cell3.textView.font=[UIFont boldSystemFontOfSize:16];
    cell3.textView.placeholder=@"editable address";
    
    TKLabelTextFieldCell *cell4=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.label.componentsAndPlainText=[cell4 labelName:@"市內電話:" required:YES];
    cell4.field.placeholder=@"editable tel";
    
    TKLabelTextFieldCell *cell5=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell5.label.componentsAndPlainText=[cell5 labelName:@"手機:" required:YES];
    cell5.field.placeholder=@"editable phone";
    
    TKLabelTextFieldCell *cell6=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell6.label.componentsAndPlainText=[cell6 labelName:@"Email:" required:NO];
    cell6.field.placeholder=@"editable email";
    
    TKLabelTextViewCell *cell7=[[[TKLabelTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell7.label.componentsAndPlainText=[cell7 labelName:@"備註:" required:NO];
    cell7.textView.font=[UIFont boldSystemFontOfSize:16];
    cell7.textView.placeholder=@"editable memo";
    
    TKLabelTextFieldCell *cell8=[[[TKLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell8.label.componentsAndPlainText=[cell8 labelName:@"案件密碼:" required:YES];
    cell8.field.secureTextEntry=YES;
    cell8.field.placeholder=@"editable phone";
    
    NSArray *arr=[NSArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8, nil];
    NSArray *heights=[NSArray arrayWithObjects:[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:120],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:120],[NSNumber numberWithFloat:44], nil];
    return [NSDictionary dictionaryWithObjectsAndKeys:arr,@"contact",heights,@"contactHeights", nil];
}
@end
