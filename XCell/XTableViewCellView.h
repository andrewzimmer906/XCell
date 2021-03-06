///////////////////////////////////////////////////////////////////
//
//  XTableViewCellView.h
//  XCell
//
//  This class is used to draw the view for the XTableViewCell.
//  It can be overriden to do custom drawing for your own cells,
//  see the twitter example.
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@class XTableViewCellModel;
@interface XTableViewCellView : UIView {
    XTableViewCellModel *_model;
}

-(void)setModel:(XTableViewCellModel*)model;

@end
