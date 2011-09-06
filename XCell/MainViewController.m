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
            [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"XCELL_STANDARD"],
            [XTableViewCellModel modelWithType:XCELL_STANDARD_WITH_WRAPPING 
                                     withTitle:@"XCELL_STANDARD_WITH_WRAPPING, another normal cell, but this time with wrapping capabilities."],
            [XTableViewCellModel modelWithType:XCELL_SETTINGS withTitle:@"XCELL_SETTINGS" withContent:@"Apple's value1"],
            [XTableViewCellModel modelWithType:XCELL_CONTACTS withTitle:@"XCELL_CONTACTS" withContent:@"Apple's value2"],
            [XTableViewCellModel modelWithType:XCELL_SUBTITLE withTitle:@"XCELL_SUBTITLE" withContent:@"Apple's SUBTITLE except that my version supports wrapping inside the cell view."],
            [XTableViewCellModel modelWithType:XCELL_TITLE_CONTENT withTitle:@"XCELL_TITLE_CONTENT:" withContent:@"Supports one line of content."],
            [XTableViewCellModel modelWithType:XCELL_TITLE_CONTENT_WITH_WRAPPING withTitle:@"Short Title:" withContent:@"XCELL_TITLE_CONTENT_WITH_WRAPPING. Supports multiple lines of content with an autogrow/stretch to size the cell correctly to wrapping content."],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"XCELL_TITLE_CONTENT:" withContent:@"Supports one line of content." withDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"XCELL_TITLE_CONTENT:" withContent:@"Supports one line of content." withDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"XCELL_TITLE_CONTENT:" withContent:@"Supports one line of content." withDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT_WITH_TITLE withTitle:@"XCELL_TITLE_CONTENT:" withContent:@"Supports one line of content." withDelegate:self],
            nil];
}
@end