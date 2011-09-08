//
//  XTableViewCellView.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "XTableViewCellView.h"
#import "XTableViewCellModel.h"

@interface XTableViewCellView(Private)
-(void)setupView;

//Drawing Functions
-(void)drawTitle:(NSString*)title withWrapping:(BOOL)wrapping;
-(void)drawTitle:(NSString *)title withContent:(NSString*)content withWrapping:(BOOL)wrapping;
-(void)drawTitle:(NSString *)title withSubcontent:(NSString*)content;
@end

@implementation XTableViewCellView

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Setters
-(void)setModel:(XTableViewCellModel*)model {
    _model = model;
}

#pragma mark - Drawing
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_model == nil) {
        return;
    }
    
    //as much as I HATE switch statements.. Here we are.
    switch (_model.type) {
        case XCELL_STANDARD:
            [self drawTitle:_model.title withWrapping:NO];
            break;
            
        case XCELL_STANDARD_WITH_WRAPPING:
            [self drawTitle:_model.title withWrapping:YES];
            break;
            
        case XCELL_SETTINGS:
        case XCELL_CONTACTS:
        case XCELL_TITLE_CONTENT:
            [self drawTitle:_model.title withContent:_model.content withWrapping:NO];
            break;
            
        case XCELL_SUBTITLE:
            [self drawTitle:_model.title withSubcontent:_model.content];
            break;
            
            
        case XCELL_TITLE_CONTENT_WITH_WRAPPING:
            [self drawTitle:_model.title withContent:_model.content withWrapping:YES];
            break;
            
        case XCELL_EDITABLE_TEXT_WITH_TITLE:
            [self drawTitle:_model.title withWrapping:NO];
            break;
            
        default:
            break;
    }
}

@end

#pragma mark - Private -
@implementation XTableViewCellView(Private)

/* Do anything needed for initial cell setup here */
-(void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

#pragma mark Drawing
/* Draw a title for a cell */
-(void)drawTitle:(NSString*)title withWrapping:(BOOL)wrapping {
    NSInteger textWidth = self.frame.size.width - _model.padding.left - _model.padding.right;
    
    [_model.titleColor set];
    
    CGSize titleSize;
    if(wrapping) {
        titleSize = [title sizeWithFont:_model.titleFont
                      constrainedToSize:CGSizeMake(textWidth, 9999)
                          lineBreakMode:UILineBreakModeTailTruncation];
    } else {
        titleSize = [title sizeWithFont:_model.titleFont
                      constrainedToSize:CGSizeMake(textWidth, 0)
                          lineBreakMode:UILineBreakModeTailTruncation];
    }
    
    
    NSInteger cellHeight = titleSize.height + _model.padding.top + _model.padding.bottom;
    if(cellHeight < _model.minimumHeight) {
        cellHeight = _model.minimumHeight;
    }
    
    [title drawInRect:CGRectMake(_model.padding.left, (cellHeight - titleSize.height) / 2, textWidth, titleSize.height) 
             withFont:_model.titleFont 
        lineBreakMode:UILineBreakModeTailTruncation 
            alignment:_model.titleAlignment];
}

/* Draw a title and the content right next to it */
-(void)drawTitle:(NSString *)title withContent:(NSString*)content withWrapping:(BOOL)wrapping {
    NSInteger textWidth = self.frame.size.width - _model.padding.left - _model.padding.right;
    
    CGSize titleSize = [title sizeWithFont:_model.titleFont
                         constrainedToSize:CGSizeMake(textWidth, 0)
                             lineBreakMode:UILineBreakModeTailTruncation];
    CGSize singleLineContentSize = [content sizeWithFont:_model.contentFont
                                       constrainedToSize:CGSizeMake(textWidth - titleSize.width - 5, 0)
                                           lineBreakMode:UILineBreakModeTailTruncation];
    CGSize contentSize;
    
    if(wrapping) {
        contentSize = [content sizeWithFont:_model.contentFont
                          constrainedToSize:CGSizeMake(textWidth - titleSize.width - 5, 9999)
                              lineBreakMode:UILineBreakModeTailTruncation];
    } else {
        contentSize = [content sizeWithFont:_model.contentFont
                          constrainedToSize:CGSizeMake(textWidth - titleSize.width - 5, 0)
                              lineBreakMode:UILineBreakModeTailTruncation];
    }
    
    
    NSInteger cellHeight = titleSize.height + _model.padding.top + _model.padding.bottom;
    if(cellHeight < _model.minimumHeight) {
        cellHeight = _model.minimumHeight;
    }
    
    [_model.titleColor set];
    [title drawInRect:CGRectMake(_model.padding.left, (cellHeight - titleSize.height) / 2, titleSize.width, titleSize.height) 
             withFont:_model.titleFont 
        lineBreakMode:UILineBreakModeTailTruncation 
            alignment:_model.titleAlignment];
    
    NSInteger adjustY = 1;
    if(singleLineContentSize.height > titleSize.height) { adjustY = -1; }
    
    [_model.contentColor set];
    [content drawInRect:CGRectMake(_model.padding.left + titleSize.width + 5, 
                                   (cellHeight - titleSize.height) / 2 + (titleSize.height - singleLineContentSize.height) - adjustY, 
                                   self.frame.size.width - (_model.padding.left + titleSize.width + 5) - _model.padding.right, 
                                   contentSize.height) 
               withFont:_model.contentFont
          lineBreakMode:UILineBreakModeTailTruncation 
              alignment:_model.contentAlignment];
}

/* Draw a title with the content below it */
-(void)drawTitle:(NSString *)title withSubcontent:(NSString*)content {
    NSInteger textWidth = self.frame.size.width - _model.padding.left - _model.padding.right;
    
    CGSize titleSize = [title sizeWithFont:_model.titleFont
                         constrainedToSize:CGSizeMake(textWidth, 0)
                             lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize contentSize = [content sizeWithFont:_model.contentFont
                             constrainedToSize:CGSizeMake(textWidth, 9999)
                                 lineBreakMode:UILineBreakModeTailTruncation];
    
    NSInteger cellHeight = titleSize.height + 5 + contentSize.height + _model.padding.top + _model.padding.bottom;
    if(cellHeight < _model.minimumHeight) {
        cellHeight = _model.minimumHeight;
    }
    
    [_model.titleColor set];
    [title drawInRect:CGRectMake(_model.padding.left, _model.padding.top, titleSize.width, titleSize.height) 
             withFont:_model.titleFont 
        lineBreakMode:UILineBreakModeTailTruncation 
            alignment:_model.titleAlignment];
    
    [_model.contentColor set];
    [content drawInRect:CGRectMake(_model.padding.left, _model.padding.top + titleSize.height + 5, contentSize.width, contentSize.height) 
               withFont:_model.contentFont
          lineBreakMode:UILineBreakModeTailTruncation 
              alignment:_model.contentAlignment];
}
@end