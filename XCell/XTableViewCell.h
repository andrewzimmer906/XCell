///////////////////////////////////////////////////////////////////
//
//  XTableViewCell.h
//  XCell
//
//  This UITableViewCell override is a core portion of the XCell system.
//  It allows the cell to draw itself for better performance, and
//  accept a XTableViewCellModel which defines the appearance and
//  functionality of the cell. This class can be overriden to 
//  create custom cells.  You should also override XTableViewCellView
//  to create a custom cell.
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "XTableViewCellBackgroundView.h"

@class XTableViewCellModel;
@class XTableViewCellView;

@interface XTableViewCell : UITableViewCell<UITextFieldDelegate> {
    XTableViewCellModel *_model;
    XTableViewCellView *_cellView;
    XTableViewCellBackgroundView *_cellBackground;
    UITextField *_textField;
}

-(XTableViewCellModel*)model;
-(void)setModel:(XTableViewCellModel*)model;
-(void)setCellPosition:(XCellPosition)value;
-(void)redisplay;
-(void)beginEditing;
-(void)endEditing;

+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth withTableStyle:(UITableViewStyle)style;
+(NSString*)cellIdentifier;

@end
