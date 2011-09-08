//
//  CustomizationViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "CustomizationViewController.h"
#import "XTableViewCellModel.h"
#import "XTableViewController.h"

@interface CustomizationViewController(Private)
-(NSArray*)tableData;
@end

@implementation CustomizationViewController
@synthesize tableView;

#pragma mark - Memory Management
-(void)dealloc {
    [tableView release];
    [_tableController release];
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Customized Cells";
    _tableController = [[XTableViewController alloc] initWithTableView:tableView];
    _tableController.delegate = self;
    _tableController.sortSectionsAlphabetically = YES;
    [_tableController setDataWithArray:[self tableData]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - XTableViewControllerDelegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    [_tableController beginEditingWithModel:model];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    [textField resignFirstResponder];
    [_tableController endEditingWithModel:model];
    
    return YES;
}

@end

@implementation CustomizationViewController(Private)

-(NSArray*)tableData {
    XTableViewCellModel *cell1 = [XTableViewCellModel modelWithType:XCELL_STANDARD_WITH_WRAPPING withTitle:@"Is that a new font? Looks AMAZING!"];
    cell1.titleFont = [UIFont fontWithName:@"Arial" size:20];
    cell1.titleColor = [UIColor redColor];
    cell1.backgroundColor = [UIColor darkGrayColor];
    
    XTableViewCellModel *cell2 = [XTableViewCellModel modelWithType:XCELL_TITLE_CONTENT_WITH_WRAPPING withTitle:@"MOAR Padding!" withContent:@"It's all for Sir Paddington. He really loves his padding."];
    cell2.contentFont = [UIFont boldSystemFontOfSize:17];
    cell2.contentColor = [UIColor purpleColor];
    cell2.padding = UIEdgeInsetsMake(30, 50, 30, 10);    
    
    XTableViewCellModel *cell3 = [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT_WITH_TITLE withTitle:@"Get Ready:" withContent:@"To Google!!" withAccesoryType:UITableViewCellAccessoryNone withTag:-1 withEditingDelegate:self];
    cell3.titleFont = [UIFont systemFontOfSize:12];
    cell3.returnKeyType = UIReturnKeyGoogle;
    cell3.textFieldClearButtonMode = UITextFieldViewModeWhileEditing;
    cell3.textFieldBorderStyle = UITextBorderStyleLine;
    
    XTableViewCellModel *cell4 = [XTableViewCellModel modelWithType:XCELL_STANDARD_WITH_WRAPPING withTitle:@"Yeah, I'm centered."];
    cell4.titleAlignment = UITextAlignmentCenter;
    
    XTableViewCellModel *cell5 = [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Look how tiny I am!"];
    cell5.titleFont = [UIFont systemFontOfSize:10];
    cell5.minimumHeight = 10;
    cell5.accessory = UITableViewCellAccessoryCheckmark;

    return [NSArray arrayWithObjects:cell1, cell2, cell3, cell4, cell5, nil];
}

@end
