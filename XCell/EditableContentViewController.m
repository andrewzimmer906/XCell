//
//  EditableContentViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import "EditableContentViewController.h"
#import "XTableViewCellModel.h"
#import "XTableViewController.h"

@interface EditableContentViewController(Private)
-(NSArray*)tableData;
@end

@implementation EditableContentViewController
@synthesize tableView;
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

@implementation EditableContentViewController(Private)

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

@end
