///////////////////////////////////////////////////////////////////
//
//  TwitterViewController.h
//  XCell
//
//  View Controller for the twitter override screen and performance
//  test.
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewController;

@interface TwitterViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
