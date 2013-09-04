//
//  CaseCategories.m
//  CaseSearch
//
//  Created by rang on 13-8-6.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCategories.h"
#import "TheProjectCell.h"
#import "TreeViewNode.h"
#import "CircularTypeOperate.h"

#define circularTypeDic [NSDictionary dictionaryWithObjectsAndKeys:@"CircularRoadType",@"A",@"CircularLightType",@"B",@"CircularEPType",@"C",@"CircularTaxType",@"E", nil]

@interface CaseCategories (){
    NSUInteger indentation;
    NSArray *nodes;
}
- (void)expandCollapseNode:(NSNotification *)notification;
- (void)fillDisplayArray;
- (void)fillNodesArray;
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray;

- (IBAction)expandAll:(id)sender;
- (IBAction)collapseAll:(id)sender;

-(NSMutableArray*)getBindData:(CircularTypeOperate*)opetate parent:(NSString*)name level:(int)level;
@end

@implementation CaseCategories
@synthesize displayArray=_displayArray;
@synthesize showType=_showType;
@synthesize showLevel=_showLevel;
@synthesize delegate;
-(void)dealloc{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_displayArray release];
    [_showType release];
    if (nodes) {
        [nodes release];
        nodes=nil;
    }
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
    indentation=-1;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(expandCollapseNode:) name:@"ProjectTreeNodeButtonClicked" object:nil];
    [self fillNodesArray];
    [self fillDisplayArray];
    [self.tableView reloadData];
    
}
- (IBAction)expandAll:(id)sender
{
    [self fillNodesArray];
    [self fillDisplayArray];
    [self.tableView reloadData];
}

- (IBAction)collapseAll:(id)sender
{
    for (TreeViewNode *treeNode in nodes) {
        treeNode.isExpanded = NO;
    }
    [self fillDisplayArray];
    [self.tableView reloadData];
}

- (void)fillDisplayArray
{
    if (!self.displayArray) {
       self.displayArray = [[NSMutableArray alloc] init];
    }
    [self.displayArray removeAllObjects];
    for (TreeViewNode *node in nodes) {
        if (![self.displayArray containsObject:node]) {
             [self.displayArray addObject:node];
        }
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}
- (void)fillNodeWithChildrenArray:(NSArray *)childrenArray
{
    for (TreeViewNode *node in childrenArray) {
        [self.displayArray addObject:node];
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
}

#pragma mark - Messages to fill the tree nodes and the display array
//This function is used to expand and collapse the node as a response to the ProjectTreeNodeButtonClicked notification
- (void)expandCollapseNode:(NSNotification *)notification
{
    [self fillDisplayArray];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 私有方法
- (void)fillNodesArray{
    CircularTypeOperate *entity=[CircularTypeOperate CirularTypesUnArchiver];
    entity.circularTypeSource=[entity.circularTypes objectForKey:self.showType];
    if (entity.circularTypeSource&&[entity.circularTypeSource count]>0) {
        NSArray *firstLevel=[entity childCircularTypes:@"" level:@"1"];
        NSMutableArray *bindArr=[NSMutableArray array];
        for (CircularType *item in firstLevel) {
            TreeViewNode *firstLevelNode1 =[[[TreeViewNode alloc] init] autorelease];
            firstLevelNode1.nodeLevel = 0;
            firstLevelNode1.nodeObject =item;
            firstLevelNode1.isExpanded = NO;
            if (self.showLevel>=2) {
                NSMutableArray *childs=[self getBindData:entity parent:item.GUID level:2];
                if (childs&&[childs count]>0) {
                    firstLevelNode1.nodeChildren=childs;
                }
            }
            [bindArr addObject:firstLevelNode1];
        }
        nodes=[bindArr retain];
    }else{
        NSMutableArray *params=[NSMutableArray array];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.showType,@"categorty", nil]];
        ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
        args.methodName=@"GetCategoryByCircular";
        args.soapParams=params;
        [ServiceHelper asynService:args completed:^(ServiceResult *result) {
            NSArray *source=[result.xmlParse childNodesToObject:@"CircularType"];
            //[result.xmlParse soapXmlSelectNodes:[NSString stringWithFormat:@"//%@",[circularTypeDic objectForKey:self.showType]]];
            [self performSelectorOnMainThread:@selector(LoadSourceData:) withObject:source waitUntilDone:NO];
        } failed:^(NSError *error, NSDictionary *userInfo) {
            
        }];
    }
}
-(void)LoadSourceData:(NSArray*)source{
    if (source&&[source count]>0) {
        CircularTypeOperate *entity=[[[CircularTypeOperate alloc] init] autorelease];
        entity.circularTypeSource=source;
        //[entity.circularTypes objectForKey:self.showType];
        NSArray *firstLevel=[entity childCircularTypes:@"" level:@"1"];
        NSMutableArray *bindArr=[NSMutableArray array];
        for (CircularType *item in firstLevel) {
            TreeViewNode *firstLevelNode1 =[[[TreeViewNode alloc] init] autorelease];
            firstLevelNode1.nodeLevel = 0;
            firstLevelNode1.nodeObject =item;
            firstLevelNode1.isExpanded = NO;
            if (self.showLevel>=2) {
                 NSMutableArray *childs=[self getBindData:entity parent:item.GUID level:2];
                if (childs&&[childs count]>0) {
                    firstLevelNode1.nodeChildren=childs;
                }

            }
            [bindArr addObject:firstLevelNode1];
        }
        nodes=[bindArr retain];
    }else{
        nodes=[NSMutableArray array];
    }
}
-(NSMutableArray*)getBindData:(CircularTypeOperate*)opetate parent:(NSString*)name level:(int)level{
    NSArray *arr=[opetate childCircularTypes:name level:[NSString stringWithFormat:@"%d",level]];
    
    //NSLog(@"child-arr=%@\n",arr);
    if (arr&&[arr count]>0) {
        return nil;
    }
    NSMutableArray *result=[NSMutableArray array];
    for (CircularType *item in result) {
        TreeViewNode *firstLevelNode1 =[[[TreeViewNode alloc] init] autorelease];
        firstLevelNode1.nodeLevel = level-1;
        firstLevelNode1.nodeObject =item;
        firstLevelNode1.isExpanded = NO;
        if (self.showLevel==3) {
            NSMutableArray *childs=[self getBindData:opetate parent:item.GUID level:3];
            if (childs&&[childs count]>0) {
              firstLevelNode1.nodeChildren=[self getBindData:opetate parent:item.GUID level:3];
            }
        }
        [result addObject:firstLevelNode1];
    }
    return result;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"treeNodeCell";
    UINib *nib = [UINib nibWithNibName:@"ProjectCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    TheProjectCell *cell = (TheProjectCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    cell.treeNode = node;
    
    
    CircularType *entity=(CircularType*)node.nodeObject;
    
    cell.cellLabel.text =entity.Name;
    
    if (node.isExpanded) {
        [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Open"]];
    }
    else {
        [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"Close"]];
    }
    [cell setNeedsDisplay];
    
    cell.accessoryType=indentation==indexPath.row?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int newRow=indexPath.row;
    if(newRow!=indentation){
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (indentation!=-1) {
            NSIndexPath *oldIndexPath=[NSIndexPath indexPathForItem:indentation inSection:0];
            UITableViewCell *oldCell=[tableView cellForRowAtIndexPath:oldIndexPath];
            oldCell.accessoryType=UITableViewCellAccessoryNone;
        }
        indentation=newRow;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedTableRowCircularType:)]) {
         TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
        CircularType *entity=(CircularType*)node.nodeObject;
        SEL addMethod = NSSelectorFromString(@"selectedTableRowCircularType:");
        [self.delegate performSelector:addMethod withObject:entity.Name];
        //[self.delegate selectedTableRowVillage:[self.listData objectAtIndex:currentIndex]];
    }
}

@end
