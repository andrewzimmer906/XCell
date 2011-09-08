///////////////////////////////////////////////////////////////////
//
//  XTableViewControllerDelegate.h
//  XCell
//
//  Defines delegate methods for a ViewController to implement
//  when using an XTableViewController to handle a UITableView.
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
@class XTableViewCellModel;

@protocol XTableViewControllerDelegate <NSObject>
@optional
-(void)cellClicked:(NSIndexPath*)path;  //Load a new view or something!

#pragma mark - Text Field Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;
- (void)textFieldDidEndEditing:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string forCellModel:(XTableViewCellModel*)model;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;

- (BOOL)textFieldShouldClear:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;
- (BOOL)textFieldShouldReturn:(UITextField *)textField forCellModel:(XTableViewCellModel*)model;

@end
