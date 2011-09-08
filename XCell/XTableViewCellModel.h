//
//  XTableViewCellModel.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTableViewControllerDelegate.h"
#import "XTableViewCellTypes.h"

@interface XTableViewCellModel : NSObject {

}

//init
-(id)initWithType:(XTableViewCellStyle)eType;

// Convenience Initialization Methods
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title;

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content;

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content 
  withAccesoryType:(UITableViewCellAccessoryType)accessory;


+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content 
                                             withAccesoryType:(UITableViewCellAccessoryType)accessory
                                             withTag:(NSInteger)tag;

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content 
                                             withAccesoryType:(UITableViewCellAccessoryType)accessory 
                                             withTag:(NSInteger)tag 
                                             withEditingDelegate:(id<XTableViewControllerDelegate>)delegate;

#pragma mark Properties
@property XTableViewCellStyle type;

// Data
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) NSString *textFieldData;
@property(nonatomic, retain) id data;  //used for whatever you want for your own custom cells.

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
@property(nonatomic) UITableViewCellAccessoryType accessory;

@property(nonatomic, retain) UIColor *backgroundColor;

@end