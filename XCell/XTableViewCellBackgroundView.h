///////////////////////////////////////////////////////////////////
//
//  XTableViewCellBackgroundView.h
//  XCell
//
//  This class is used to draw a custom background for UITableViewCells in the grouped view style.
//  It is not used in standard style cells.
//
//  Created by Andrew Zimmer on 9/8/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
//  Inspired By:
//
//  CustomCellBackgroundView.m
//
//  Created by Mike Akers on 11/21/08.
//  Copyright 2008. All rights reserved.
//
///////////////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>

//The position of the cell in the table.  Used to determine how to round the corners.
typedef enum {
    XCELL_TOP,
    XCELL_MIDDLE,
    XCELL_BOTTOM,
    XCELL_SINGLE,
    XCELL_NORMAL
}XCellPosition;

@interface XTableViewCellBackgroundView : UIView {
    UIColor *borderColor;
    UIColor *fillColor;
    XCellPosition position;
}

@property(nonatomic, retain) UIColor *borderColor, *fillColor;
@property(nonatomic) XCellPosition position;

@end

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight);