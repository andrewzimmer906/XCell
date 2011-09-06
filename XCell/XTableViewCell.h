//
//  XTableViewCell.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewCellModel;
@interface XTableViewCell : UITableViewCell {
    XTableViewCellModel *_model;
}

-(XTableViewCellModel*)model;
-(void)setModel:(XTableViewCellModel*)model;

+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth;
+(NSString*)cellIdentifier;

@end
