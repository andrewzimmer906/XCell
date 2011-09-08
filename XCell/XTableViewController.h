///////////////////////////////////////////////////////////////////
//
//  XTableViewController.h
//  XCell
//
//  A Table View Controller that handles all the nitty gritty of
//  implementing a tableView with any sort of custom cells (as long 
//  as they inherit from XTableViewCell.
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////


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
    NSInteger _keyboardHeight;
    NSInteger _previousKeyboardHeight;
}

@property(nonatomic, assign) id<XTableViewControllerDelegate> delegate; // The delegate for this controller. Used 
                                                                        // to alert UIViewControllers when a cell has been selected.    
@property(nonatomic, retain) Class cellClass;   //The cellClass to create cells from. Must inherit from XTableViewCell.
@property BOOL sortSectionsAlphabetically;      //If set to true, the sections in the tableview are sorted alphabetically.

//Initialization
-(id)initWithTableView:(UITableView*)tableView;

//Set the Data
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