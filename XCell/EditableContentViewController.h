///////////////////////////////////////////////////////////////////
//
//  EditableContentViewController.h
//  XCell
//
//  View Controller for the editable content cell example.
// 
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewController;
@class XTableViewCellModel;

@interface EditableContentViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
    UITextField *_curTextField;
    XTableViewCellModel *_curCellModel;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
