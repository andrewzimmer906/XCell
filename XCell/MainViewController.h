//
//  MainViewController.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "XTableViewControllerDelegate.h"

@class XTableViewController;

@interface MainViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
