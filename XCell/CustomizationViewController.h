///////////////////////////////////////////////////////////////////
//
//  CustomizationViewController.h
//  XCell
//
//  View Controller for the cell customization example.
// 
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewController;

@interface CustomizationViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end