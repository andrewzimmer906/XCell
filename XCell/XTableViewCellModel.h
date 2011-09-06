//
//  XTableViewCellModel.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    XCELL_STANDARD,  // Standard Cell Style DEFAULT
    XCELL_STANDARD_WITH_WRAPPING,
    XCELL_SETTINGS,  // Standard Cell Value1
    XCELL_CONTACTS,  // Standard Cell Value2
    XCELL_SUBTITLE,  // Standard Cell Subtitle
    XCELL_TITLE_CONTENT,
    XCELL_TITLE_CONTENT_WITH_WRAPPING,
}XTableViewCellStyle;

@interface XTableViewCellModel : NSObject {

}

// Convenience Initialization Methods
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title;
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content;

#pragma mark Properties
@property XTableViewCellStyle type;

// Data
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) id data;

// Appearance
@property(nonatomic, retain) UIFont *titleFont;
@property(nonatomic, retain) UIColor *titleColor;
@property UITextAlignment titleAlignment;

@property(nonatomic, retain) UIFont *contentFont;
@property(nonatomic, retain) UIColor *contentColor;
@property UITextAlignment contentAlignment;

@property(nonatomic) UIEdgeInsets padding;
@property NSInteger minimumHeight;

@property BOOL selectable;
@property BOOL showDisclosureIndicator;

@property(nonatomic, retain) UIColor *backgroundColor;

@end