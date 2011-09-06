//
//  XTableViewCellModel.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Modea. All rights reserved.
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
+(void)setDefaults:(XTableViewCellModel*)model;
@end

@implementation XTableViewCellModel
@synthesize type, title, content, data, selectable, titleFont, contentFont, padding, minimumHeight,
            titleColor, contentColor, titleAlignment, contentAlignment, backgroundColor, showDisclosureIndicator;

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
+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title {
    XTableViewCellModel *model = [[XTableViewCellModel alloc] init];
    if(model) {
        model.type = type;
        model.title = title;
        [XTableViewCellModel setDefaults:model];
    }
    return model;
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString*)content {
    XTableViewCellModel *model = [[XTableViewCellModel alloc] init];
    if(model) {
        model.type = type;
        model.title = title;
        model.content = content;
        [XTableViewCellModel setDefaults:model];
    }
    return model;
}
@end

#pragma mark - Private -
@implementation XTableViewCellModel(Private)

/* Sets the defaults for the model. Used in initilization */
+(void)setDefaults:(XTableViewCellModel*)model {
    model.selectable = YES;
    model.showDisclosureIndicator = NO;
    
    model.titleFont = DEFAULT_TITLE_FONT;
    model.titleAlignment = DEFAULT_TITLE_ALIGNMENT;
    model.titleColor = DEFAULT_TITLE_COLOR;
    
    model.contentFont = DEFAULT_CONTENT_FONT;
    model.contentAlignment = DEFAULT_CONTENT_ALIGNMENT;
    model.contentColor = DEFAULT_CONTENT_COLOR;
    
    model.padding = UIEdgeInsetsMake(DEFAULT_VERTICAL_PADDING, DEFAULT_HORIZONTAL_PADDING, DEFAULT_VERTICAL_PADDING, DEFAULT_HORIZONTAL_PADDING);
    model.minimumHeight = DEFAULT_MINIMUM_HEIGHT;
    
    model.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    //set extra stuff based on type
    if(model.type == XCELL_SETTINGS) {
        model.contentColor = [UIColor colorWithRed:0.195f green:.309f blue:.520f alpha:1];
        model.contentAlignment = UITextAlignmentRight;
        model.contentFont = [UIFont systemFontOfSize:17];
    }
    
    if(model.type == XCELL_CONTACTS) {
        model.contentColor = DEFAULT_TITLE_COLOR;
        model.contentFont = DEFAULT_TITLE_FONT;
        model.contentAlignment = UITextAlignmentLeft;
        
        model.titleFont = [UIFont boldSystemFontOfSize:12];
        model.titleColor = [UIColor colorWithRed:0.195f green:.309f blue:.520f alpha:1];
    }
}

@end
