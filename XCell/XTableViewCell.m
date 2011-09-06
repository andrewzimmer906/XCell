//
//  XTableViewCell.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "XTableViewCell.h"
#import "XTableViewCellModel.h"

@interface XTableViewCell(Private)
-(void)setupView;

//Drawing Functions
-(CGSize)drawTitle:(NSString*)title withWrapping:(BOOL)wrapping;
-(void)drawTitle:(NSString *)title withContent:(NSString*)content withWrapping:(BOOL)wrapping;
-(void)drawTitle:(NSString *)title withSubcontent:(NSString*)content;

//Height Functions
+(CGFloat)heightForTitle:(NSString*)title withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth;
+(CGFloat)heightForTitle:(NSString *)title withContent:(NSString*)content withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth;
+(CGFloat)heightForTitle:(NSString*)title withSubContent:(NSString*)content withModel:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth;

@end

@implementation XTableViewCell

#pragma mark - Memory Management
-(void)dealloc {
    [super dealloc];
}

#pragma mark - Initilization
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Getters/Setters
-(XTableViewCellModel*)model {
    return _model;
}

-(void)setModel:(XTableViewCellModel*)model {
    _model = model;
    
    if(_model.selectable) {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.backgroundColor = _model.backgroundColor;
    
    if(_textField) {
        [_textField removeFromSuperview];
        [_textField release];
        _textField = nil;
    }
    
    if(_model.type == XCELL_EDITABLE_TEXT || _model.type == XCELL_EDITABLE_TEXT_WITH_TITLE) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(_model.padding.left, 
                                                                   _model.padding.top, 
                                                                   self.frame.size.width - _model.padding.right - _model.padding.left, 
                                                                   _model.minimumHeight - _model.padding.top - _model.padding.bottom)];
        _textField.borderStyle = _model.textFieldBorderStyle;
        _textField.clearButtonMode = _model.textFieldClearButtonMode;
        _textField.keyboardType = _model.keyboardType;
        _textField.returnKeyType = _model.returnKeyType;
        _textField.autocapitalizationType = _model.autocapitilizationType;
        _textField.autocorrectionType = _model.autocorrectionType;
        _textField.placeholder = _model.content;
        _textField.delegate = self;
        
        [self addSubview:_textField];
    }
}

-(void)beginEditing {
    if(_textField) {
        [_textField becomeFirstResponder];
    }
}

-(void)endEditing {
    if(_textField) {
        [_textField resignFirstResponder];
    }
}

#pragma mark - Static Methods
+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth {
    switch (model.type) {
        case XCELL_STANDARD:
        case XCELL_SETTINGS:
        case XCELL_CONTACTS:
        case XCELL_TITLE_CONTENT:
            return [self heightForTitle:model.title withModel:model withWrapping:NO withTableWidth:tableWidth];
            break;
            
        case XCELL_STANDARD_WITH_WRAPPING:
            return [self heightForTitle:model.title withModel:model withWrapping:YES withTableWidth:tableWidth];
            break;
            
        case XCELL_SUBTITLE:
            return [self heightForTitle:model.title withSubContent:model.content withModel:model withTableWidth:tableWidth];
            break;
            
        case XCELL_TITLE_CONTENT_WITH_WRAPPING:
            return [self heightForTitle:model.title withContent:model.content withModel:model withWrapping:YES withTableWidth:tableWidth];
            break;
            
        case XCELL_EDITABLE_TEXT:
        case XCELL_EDITABLE_TEXT_WITH_TITLE:
            break;
    }
    
    return model.minimumHeight;
}

+(NSString*)cellIdentifier {
    return @"XTableViewCellIdentifier";
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
        {
            CGSize titleSize = [self drawTitle:_model.title withWrapping:NO];
            if(_textField) {
                _textField.frame = CGRectMake(titleSize.width + _model.padding.left + 5, 
                                              _textField.frame.origin.y, 
                                              self.frame.size.width - _model.padding.left - _model.padding.right - titleSize.width - 5,
                                              _textField.frame.size.height);
            }
        }
            break;
            
        case XCELL_EDITABLE_TEXT:
            break;
    }
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldDidBeginEditing:forCellModel:)]) {
            [_model.delegate textFieldDidBeginEditing:textField forCellModel:_model];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldDidEndEditing:forCellModel:)]) {
            [_model.delegate textFieldDidEndEditing:textField forCellModel:_model];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:forCellModel:::)]) {
            return [_model.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string forCellModel:_model];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:forCellModel:)]) {
            return [_model.delegate textFieldShouldBeginEditing:textField forCellModel:_model];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldShouldEndEditing:forCellModel:)]) {
            return [_model.delegate textFieldShouldEndEditing:textField forCellModel:_model];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldShouldClear:forCellModel:)]) {
            return [_model.delegate textFieldShouldClear:textField forCellModel:_model];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(_model.delegate != nil) {
        if([_model.delegate respondsToSelector:@selector(textFieldShouldReturn:forCellModel:)]) {
            return [_model.delegate textFieldShouldReturn:textField forCellModel:_model];
        }
    }
    
    return YES;
}

@end

#pragma mark - Private -
@implementation XTableViewCell(Private)

/* Do anything needed for initial cell setup here */
-(void)setupView {
    _textField = nil;
}

#pragma mark Drawing
/* Draw a title for a cell */
-(CGSize)drawTitle:(NSString*)title withWrapping:(BOOL)wrapping {
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
    
    return titleSize;
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

#pragma mark Height Calculations
/* Get the height for a STANDARD or STANDARD_WITH_WRAPPING cell */
+(CGFloat)heightForTitle:(NSString*)title withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth {
    NSInteger textWidth = tableWidth - model.padding.left - model.padding.right;
    
    CGSize titleSize;
    if(wrapping) {
        titleSize = [title sizeWithFont:model.titleFont
                      constrainedToSize:CGSizeMake(textWidth, 9999)
                          lineBreakMode:UILineBreakModeTailTruncation];
    } else {
        titleSize = [title sizeWithFont:model.titleFont
                      constrainedToSize:CGSizeMake(textWidth, 0)
                          lineBreakMode:UILineBreakModeTailTruncation];
    }
    
    NSInteger cellHeight = titleSize.height + model.padding.top + model.padding.bottom;
    if(cellHeight < model.minimumHeight) {
        cellHeight = model.minimumHeight;
    }
    
    return cellHeight;    
}

/* Get the height for a Content cell perhaps with wrapping */
+(CGFloat)heightForTitle:(NSString *)title withContent:(NSString*)content withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth {
    NSInteger textWidth = tableWidth - model.padding.left - model.padding.right;
    
    CGSize titleSize = [title sizeWithFont:model.titleFont
                         constrainedToSize:CGSizeMake(textWidth, 0)
                             lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize singleLineContentSize = [content sizeWithFont:model.contentFont
                                       constrainedToSize:CGSizeMake(textWidth - titleSize.width - 5, 0)
                                           lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize contentSize = [content sizeWithFont:model.contentFont
                             constrainedToSize:CGSizeMake(textWidth - titleSize.width - 5, 9999)
                                 lineBreakMode:UILineBreakModeTailTruncation];
    
    NSInteger cellHeight = titleSize.height + model.padding.top + model.padding.bottom;
    if(cellHeight < model.minimumHeight) {
        cellHeight = model.minimumHeight;
    }
    
    if(wrapping) {    
        NSInteger adjustY = 1;
        if(singleLineContentSize.height > titleSize.height) { adjustY = -1; }
        
        NSInteger contentY = (cellHeight - titleSize.height) / 2 + (titleSize.height - singleLineContentSize.height) - adjustY;

        NSInteger newSize = contentSize.height + contentY + model.padding.bottom;
        if(newSize > cellHeight) {
            return newSize;
        }
    }
    
    return cellHeight;
}

/* Get the height for a SUBTITLE type cell */
+(CGFloat)heightForTitle:(NSString*)title withSubContent:(NSString*)content withModel:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth {
    NSInteger textWidth = tableWidth - model.padding.left - model.padding.right;
    
    CGSize titleSize = [title sizeWithFont:model.titleFont
                         constrainedToSize:CGSizeMake(textWidth, 0)
                             lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize contentSize = [content sizeWithFont:model.contentFont
                             constrainedToSize:CGSizeMake(textWidth, 9999)
                                 lineBreakMode:UILineBreakModeTailTruncation];
    
    NSInteger cellHeight = titleSize.height + 5 + contentSize.height + model.padding.top + model.padding.bottom;
    if(cellHeight < model.minimumHeight) {
        cellHeight = model.minimumHeight;
    }
    
    return cellHeight;
}
@end 

