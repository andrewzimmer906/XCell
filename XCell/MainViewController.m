//
//  MainViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "MainViewController.h"
#import "XTableViewController.h"
#import "XTableViewCellModel.h"

#import "CellTypesViewController.h"
#import "EditableContentViewController.h"
#import "CustomizationViewController.h"
#import "TwitterViewController.h"

//Cell Types
typedef enum {
    CELL_TYPES,
    GROUPED,
    EDITABLE,
    CUSTOMIZED,
    CUSTOM
} MAIN_VIEW_CELLS;

@interface MainViewController(Private)
-(NSArray*)tableData;
@end

@implementation MainViewController
@synthesize tableView;

#pragma mark - Memory Mangement
-(void)dealloc {
    [_tableController release];
    [tableView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"X-Cell";
    _tableController = [[XTableViewController alloc] initWithTableView:tableView];
    _tableController.delegate = self;
    [_tableController setDataWithArray:[self tableData]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - XTableViewControllerDelegate Methods
-(void)cellClicked:(NSIndexPath *)path {
    XTableViewCellModel *model = [_tableController modelForIndexPath:path];
    switch (model.tag) {
        case CELL_TYPES:
        {
            UIViewController *detailView = [[CellTypesViewController alloc] initWithNibName:@"CellTypesViewController" bundle:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }
            break;
        
        case GROUPED:
        {
            UIViewController *detailView = [[CellTypesViewController alloc] initWithNibName:@"CellTypesViewControllerGrouped" bundle:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }
            break;
            
        case EDITABLE:
        {
            UIViewController *detailView = [[EditableContentViewController alloc] initWithNibName:@"EditableContentViewController" bundle:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }
            break;
        case CUSTOMIZED: 
        {
            UIViewController *detailView = [[CustomizationViewController alloc] initWithNibName:@"CustomizationViewController" bundle:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }
            break;
        
        case CUSTOM:
        {
            UIViewController *detailView = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }
            break;
        default:
            NSLog(@"Screen not implemented");
            break;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    [_tableController beginEditingWithModel:model];
}

-(void)textFieldDidEndEditing:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    //[_tableController endEditingWithModel:model];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    if(![_tableController beginEditingNextCell:model]) {
        [textField resignFirstResponder];
        [_tableController endEditingWithModel:model];
    }
    
    return YES;
}

@end

@implementation MainViewController(Private)
-(NSArray*)tableData {
    return [NSArray arrayWithObjects:
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Predefined Cells" withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:CELL_TYPES],
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"TableView Grouped" withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:GROUPED],
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Cells with Editable Content" withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:EDITABLE],
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Customized Cells" withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:CUSTOMIZED],
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Custom Cells + Performance" withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:CUSTOM],
            nil];
}
@end