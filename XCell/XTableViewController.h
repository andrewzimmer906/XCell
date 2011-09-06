//
//  XTableViewController.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTableViewControllerDelegate.h"

@class XTableViewCellModel;

@interface XTableViewController : NSObject<UITableViewDelegate, UITableViewDataSource> {
    @protected
    id<XTableViewControllerDelegate> delegate;
    NSDictionary *_data;
    UITableView *_tableView;
    
    BOOL _sortSectionsAlphabetically;
    
    XTableViewCellModel *_curEditingModel;
    BOOL _keyboardIsShowing;
    CGFloat _keyboardHeight;
}

@property(nonatomic, assign) id<XTableViewControllerDelegate> delegate;
@property BOOL sortSectionsAlphabetically;

//Initialization
-(id)initWithTableView:(UITableView*)tableView;

//Set the data
-(void)setDataWithDictionary:(NSDictionary*)data;
-(void)setDataWithArray:(NSArray*)array;

//Get data back
-(XTableViewCellModel*)modelForIndexPath:(NSIndexPath*)indexPath;
-(NSIndexPath*)indexPathForModel:(XTableViewCellModel*)model;

//Make cell visible for editing (Keyboard is all up in my stuff)
-(void)beginEditingWithModel:(XTableViewCellModel*)model;
-(void)endEditingWithModel:(XTableViewCellModel*)model;
-(BOOL)beginEditingNextCell:(XTableViewCellModel*)model;

@end