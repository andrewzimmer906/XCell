//
//  EditableContentViewController.h
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewController;

@interface EditableContentViewController : UIViewController<XTableViewControllerDelegate> {
    XTableViewController *_tableController;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
