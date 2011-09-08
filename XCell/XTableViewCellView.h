//
//  XTableViewCellView.h
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewCellModel;
@interface XTableViewCellView : UIView {
    XTableViewCellModel *_model;
}

-(void)setModel:(XTableViewCellModel*)model;

@end
