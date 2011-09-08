///////////////////////////////////////////////////////////////////
//
//  XTableViewCellModel.h
//  XCell
//
//  This is the model for all XTableViewCells.  This model contains 
//  information about what data the cell should display, how the cell
//  should look, and what happens when the cell is clicked on, or 
//  a textfield on a cell is interacted with.
//
//  This class is completly overridable for making your own custom cell
//  types.  Make sure to import XTableViewCellModelProtected into the *.m
//  file of any overrides.
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "XTableViewControllerDelegate.h"
#import "XTableViewCellTypes.h"

@interface XTableViewCellModel : NSObject {

}

#pragma mark - Methods
//Initialization
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

@property(nonatomic) UIEdgeInsets padding;
@property NSInteger minimumHeight;

@property BOOL selectable;
@property(nonatomic) UITableViewCellAccessoryType accessory;

@property(nonatomic, retain) UIColor *backgroundColor;
@property(nonatomic, retain) UIColor *borderColor; //Only for Grouped Table Views

//Text Field Appearance Properties
@property(nonatomic) UITextBorderStyle textFieldBorderStyle;
@property(nonatomic) UITextFieldViewMode textFieldClearButtonMode;
@property(nonatomic) UIKeyboardType keyboardType;
@property(nonatomic) UIReturnKeyType returnKeyType;
@property(nonatomic) UITextAutocapitalizationType autocapitilizationType;
@property(nonatomic) UITextAutocorrectionType autocorrectionType;

@end