//
//  XTableViewCell.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewCellModel;
@interface XTableViewCell : UITableViewCell<UITextFieldDelegate> {
    XTableViewCellModel *_model;
    UITextField *_textField;
}

-(XTableViewCellModel*)model;
-(void)setModel:(XTableViewCellModel*)model;
-(void)beginEditing;
-(void)endEditing;

+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth;
+(NSString*)cellIdentifier;

@end
