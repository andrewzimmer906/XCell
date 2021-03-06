///////////////////////////////////////////////////////////////////
//
//  CellTypesViewController.h
//  XCell
//
//  Controller to show off the different cell types.
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewController;

@interface CellTypesViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
