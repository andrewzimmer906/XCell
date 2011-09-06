//
//  XTableViewCellModel.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "XTableViewCellModel.h"

//Change these defaults to affect every cell in your project.
#define DEFAULT_HORIZONTAL_PADDING 20
#define DEFAULT_VERTICAL_PADDING 10
#define DEFAULT_MINIMUM_HEIGHT 44

#define DEFAULT_TITLE_FONT [UIFont boldSystemFontOfSize:17]
#define DEFAULT_TITLE_ALIGNMENT UITextAlignmentLeft
#define DEFAULT_TITLE_COLOR [UIColor colorWithRed:.07f green:.07f blue:.07f alpha:1]

#define DEFAULT_CONTENT_FONT [UIFont systemFontOfSize:14]
#define DEFAULT_CONTENT_ALIGNMENT UITextAlignmentLeft
#define DEFAULT_CONTENT_COLOR [UIColor colorWithRed:.66f green:.66f blue:.66f alpha:1]

#define DEFAULT_BACKGROUND_COLOR [UIColor whiteColor]
//

@interface XTableViewCellModel(Private)
-(void)setDefaults;
@end

@implementation XTableViewCellModel
@synthesize type, title, content, data, selectable, titleFont, contentFont, padding, minimumHeight,
            titleColor, contentColor, titleAlignment, contentAlignment, backgroundColor, showDisclosureIndicator, delegate, tag, textFieldBorderStyle, textFieldClearButtonMode, autocorrectionType, autocapitilizationType, keyboardType, returnKeyType, tabEnabled;

#pragma mark - Memory Management
-(void)dealloc {
    [title release];
    [content release];
    [data release];
    [titleFont release];
    [contentFont release];
    [titleColor release];
    [contentColor release];
    [backgroundColor release];
    
    [super dealloc];
}

#pragma mark - Initilization
-(id)initWithType:(XTableViewCellStyle)eType {
    if( (self = [super init]) ) {
        self.type = eType;
        [self setDefaults];
    }
    return self;
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title {
    XTableViewCellModel *model = [[[XTableViewCellModel alloc] initWithType:type] autorelease];
    if(model) {
        model.title = title;
    }
    return model;
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content {
    XTableViewCellModel *model = [[[XTableViewCellModel alloc] initWithType:type] autorelease];
    if(model) {
        model.title = title;
        model.content = content;
    }
    return model;
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content withDelegate:(id<XTableViewControllerDelegate>)delegate {
    XTableViewCellModel *model = [[[XTableViewCellModel alloc] initWithType:type] autorelease];
    if(model) {
        model.title = title;
        model.content = content;
        model.delegate = delegate;
    }
    return model;
}
@end

#pragma mark - Private -
@implementation XTableViewCellModel(Private)

/* Sets the defaults for the model. Used in initilization */
-(void)setDefaults {
    self.selectable = YES;
    self.showDisclosureIndicator = NO;
    self.tag = -1;
    self.delegate = nil;
    self.tabEnabled = NO;
    
    self.textFieldBorderStyle = UITextBorderStyleRoundedRect;
    self.textFieldClearButtonMode = UITextFieldViewModeNever;
    self.autocapitilizationType = UITextAutocapitalizationTypeSentences;
    self.autocorrectionType = UITextAutocorrectionTypeDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    
    self.titleFont = DEFAULT_TITLE_FONT;
    self.titleAlignment = DEFAULT_TITLE_ALIGNMENT;
    self.titleColor = DEFAULT_TITLE_COLOR;
    
    self.contentFont = DEFAULT_CONTENT_FONT;
    self.contentAlignment = DEFAULT_CONTENT_ALIGNMENT;
    self.contentColor = DEFAULT_CONTENT_COLOR;
    
    self.padding = UIEdgeInsetsMake(DEFAULT_VERTICAL_PADDING, DEFAULT_HORIZONTAL_PADDING, DEFAULT_VERTICAL_PADDING, DEFAULT_HORIZONTAL_PADDING);
    self.minimumHeight = DEFAULT_MINIMUM_HEIGHT;
    
    self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    //set extra stuff based on type
    if(self.type == XCELL_SETTINGS) {
        self.contentColor = [UIColor colorWithRed:0.195f green:.309f blue:.520f alpha:1];
        self.contentAlignment = UITextAlignmentRight;
        self.contentFont = [UIFont systemFontOfSize:17];
    }
    
    if(self.type == XCELL_CONTACTS) {
        self.contentColor = DEFAULT_TITLE_COLOR;
        self.contentFont = DEFAULT_TITLE_FONT;
        self.contentAlignment = UITextAlignmentLeft;
        
        self.titleFont = [UIFont boldSystemFontOfSize:12];
        self.titleColor = [UIColor colorWithRed:0.195f green:.309f blue:.520f alpha:1];
    }
    
    if(self.type == XCELL_EDITABLE_TEXT || self.type == XCELL_EDITABLE_TEXT_WITH_TITLE) {
        self.tabEnabled = YES;
        self.selectable = NO;
    }
}

@end
