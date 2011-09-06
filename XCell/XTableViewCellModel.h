//
//  XTableViewCellModel.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTableViewControllerDelegate.h"
typedef enum {
    XCELL_STANDARD,  // Standard Cell Style DEFAULT
    XCELL_SETTINGS,  // Standard Cell Value1
    XCELL_CONTACTS,  // Standard Cell Value2
    XCELL_SUBTITLE,  // Standard Cell Subtitle
    XCELL_STANDARD_WITH_WRAPPING,
    XCELL_TITLE_CONTENT,
    XCELL_TITLE_CONTENT_WITH_WRAPPING,
    XCELL_EDITABLE_TEXT,
    XCELL_EDITABLE_TEXT_WITH_TITLE
}XTableViewCellStyle;

@interface XTableViewCellModel : NSObject {

}

//Init
-(id)initWithType:(XTableViewCellStyle)eType;

// Convenience Initialization Methods
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title;
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content;
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content 
      withDelegate:(id<XTableViewControllerDelegate>)delegate;

#pragma mark Properties
@property XTableViewCellStyle type;

// Data
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) id data;

//Events
@property(nonatomic, assign) id<XTableViewControllerDelegate> delegate; //used for editing textFields
@property(nonatomic) NSInteger tag;  //used to identify the cell when clicked.
@property(nonatomic) BOOL tabEnabled;

// Appearance
@property(nonatomic, retain) UIFont *titleFont;
@property(nonatomic, retain) UIColor *titleColor;
@property UITextAlignment titleAlignment;

@property(nonatomic, retain) UIFont *contentFont;
@property(nonatomic, retain) UIColor *contentColor;
@property UITextAlignment contentAlignment;

@property(nonatomic) UITextBorderStyle textFieldBorderStyle;
@property(nonatomic) UITextFieldViewMode textFieldClearButtonMode;
@property(nonatomic) UIKeyboardType keyboardType;
@property(nonatomic) UIReturnKeyType returnKeyType;
@property(nonatomic) UITextAutocapitalizationType autocapitilizationType;
@property(nonatomic) UITextAutocorrectionType autocorrectionType;

@property(nonatomic) UIEdgeInsets padding;
@property NSInteger minimumHeight;

@property BOOL selectable;
@property BOOL showDisclosureIndicator;

@property(nonatomic, retain) UIColor *backgroundColor;

@end