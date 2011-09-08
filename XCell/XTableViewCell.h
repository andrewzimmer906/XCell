//
//  XTableViewCell.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewCellModel;
@class XTableViewCellView;

@interface XTableViewCell : UITableViewCell<UITextFieldDelegate> {
    XTableViewCellModel *_model;
    XTableViewCellView *_cellView;
    UITextField *_textField;
}

-(XTableViewCellModel*)model;
-(void)setModel:(XTableViewCellModel*)model;
-(void)redisplay;
-(void)beginEditing;
-(void)endEditing;

+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth withTableStyle:(UITableViewStyle)style;
+(NSString*)cellIdentifier;

@end
