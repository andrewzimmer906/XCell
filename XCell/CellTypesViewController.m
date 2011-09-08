///////////////////////////////////////////////////////////////////
//
//  CellTypesViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import "CellTypesViewController.h"
#import "XTableViewCellModel.h"
#import "XTableViewController.h"

@interface CellTypesViewController(Private)
-(NSDictionary*)tableData;
@end

@implementation CellTypesViewController
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
    
    self.title = @"Predefined Cells";
    _tableController = [[XTableViewController alloc] initWithTableView:tableView];
    _tableController.delegate = self;
    _tableController.sortSectionsAlphabetically = YES;
    [_tableController setDataWithDictionary:[self tableData]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end

#pragma mark - Private -
@implementation CellTypesViewController(Private)

/* Get data for the table */
-(NSDictionary*)tableData {
    NSArray *applesCells = [NSArray arrayWithObjects:
                            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Standard Cell"],
                            [XTableViewCellModel modelWithType:XCELL_SETTINGS withTitle:@"Settings" withContent:@"Value1 Style"],
                            [XTableViewCellModel modelWithType:XCELL_CONTACTS withTitle:@"Contacts" withContent:@"Value2 Style"],
                            [XTableViewCellModel modelWithType:XCELL_SUBTITLE withTitle:@"Subtitle" withContent:@"Subtitle Style"],
                            nil];
    
    for(XTableViewCellModel *model in applesCells) {
        model.selectable = NO;
    }
    
    NSArray *myCells = [NSArray arrayWithObjects:
                            [XTableViewCellModel modelWithType:XCELL_STANDARD_WITH_WRAPPING withTitle:@"A Standard Cell but with wrapping capabilities."],
                            [XTableViewCellModel modelWithType:XCELL_TITLE_CONTENT withTitle:@"Title:" withContent:@"Value for whatever"],
                            [XTableViewCellModel modelWithType:XCELL_TITLE_CONTENT_WITH_WRAPPING withTitle:@"Title:" withContent:@"Value for whatever but now it can wrap and resize the cell accordingly."],
                        nil];
    for(XTableViewCellModel *model in myCells) {
        model.selectable = YES;
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:applesCells, @"Apple's Predefined Cell Styles", myCells, @"My Custom Cell Styles", nil];
}

@end
