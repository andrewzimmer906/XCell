///////////////////////////////////////////////////////////////////
//
//  EditableContentViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import "EditableContentViewController.h"
#import "XTableViewCellModel.h"
#import "XTableViewController.h"

@interface EditableContentViewController(Private)
-(NSArray*)tableData;
-(void)addDoneBtn;
-(void)removeDoneBtn;
-(void)done:(id)sender;
@end

@implementation EditableContentViewController
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
    
    self.title = @"Editable Content";
    _tableController = [[XTableViewController alloc] initWithTableView:tableView];
    _tableController.delegate = self;
    _tableController.sortSectionsAlphabetically = YES;
    [_tableController setDataWithArray:[self tableData]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - XTableViewControllerDelegate Methods

/* 
   Called when a cell's textfield begins editing.  I let the XTableViewController know and she adjusts for the keyboard 
   size.
*/
-(void)textFieldDidBeginEditing:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    [_tableController beginEditingWithModel:model];
    _curTextField = textField;
    _curCellModel = model;
    [self addDoneBtn];
}

/*
 * Called when the return key is pressed. I tell the XTableViewController to tab to the next available textfield,
 * If there is no next textfield, I resignFirstResponder and tell the XTableViewController that we are done editing.
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField forCellModel:(XTableViewCellModel *)model {
    if(![_tableController beginEditingNextCell:model]) {
        [textField resignFirstResponder];
        [_tableController endEditingWithModel:model];
        [self removeDoneBtn];
    }
    
    return YES;
}

@end

@implementation EditableContentViewController(Private)

/* Get data to populate the table */
-(NSArray*)tableData {
    return [NSArray arrayWithObjects:
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"" withContent:@"You can edit me" 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"" withContent:@"Ooh. Me too!" 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"" withContent:@"Hey guys, you should edit me!" 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"" withContent:@"What am I chopped liver?" 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT_WITH_TITLE withTitle:@"Chopped Liver:" withContent:@"Hey! Not cool." 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT_WITH_TITLE withTitle:@"Somebody:" withContent:@"Haha, doof." 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            [XTableViewCellModel modelWithType:XCELL_EDITABLE_TEXT withTitle:@"" withContent:@"If you press return on me, the keyboard will go away!" 
                              withAccesoryType:UITableViewCellAccessoryNone withTag:0 withEditingDelegate:self],
            nil];
}

/* Used to show a done button when editing is happening */
-(void)addDoneBtn {
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneBtn;
    [doneBtn release];
}

-(void)removeDoneBtn {
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)done:(id)sender {
    [_curTextField resignFirstResponder];
    [_tableController endEditingWithModel:_curCellModel];
    [self removeDoneBtn];
}

@end
