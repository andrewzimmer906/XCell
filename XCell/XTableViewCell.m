///////////////////////////////////////////////////////////////////
//
//  XTableViewCell.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import "XTableViewCell.h"
#import "XTableViewCellModel.h"
#import "XTableViewCellView.h"

@interface XTableViewCell(Private)
-(void)setupView;

//Height Functions
+(CGFloat)heightForTitle:(NSString*)title withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth;
+(CGFloat)heightForTitle:(NSString *)title withContent:(NSString*)content withModel:(XTableViewCellModel*)model withWrapping:(BOOL)wrapping withTableWidth:(NSInteger)tableWidth;
+(CGFloat)heightForTitle:(NSString*)title withSubContent:(NSString*)content withModel:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth;

@end

@implementation XTableViewCell

#pragma mark - Memory Management
-(void)dealloc {
    if(_textField) {
        [_textField release];
    }
    [_cellView release];
    [_cellBackground release];
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

/* The model defines how the cell with appear and function */
-(void)setModel:(XTableViewCellModel*)model {
    _model = model;
    [_cellView setModel:model];
    
    if(_model.selectable) {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    self.accessoryType = _model.accessory;
    
    if(self.backgroundView) {
        _cellBackground.fillColor = _model.backgroundColor;
        _cellBackground.borderColor = _model.borderColor;
    } else {
       self.contentView.backgroundColor = _model.backgroundColor;
    }
    
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
        
        if(_model.textFieldData) {
            _textField.text = _model.textFieldData;
        }
        
        [self addSubview:_textField];
    }
    
    [self setNeedsDisplay];
}

/* 
   This is used to determine if we need to draw a custom background for a GroupedTableView 
   The drawing is handled by the XTableViewBackgroundView class.
*/
-(void)setCellPosition:(XCellPosition)value {
    if(value != XCELL_NORMAL) {
        if(!_cellBackground) {
            CGRect backgroundFrame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
            _cellBackground = [[XTableViewCellBackgroundView alloc] initWithFrame:backgroundFrame];
            _cellBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            self.backgroundView = _cellBackground;
        }
        
        if(_model) {
            _cellBackground.fillColor = _model.backgroundColor;
            _cellBackground.borderColor = _model.borderColor;
            self.contentView.backgroundColor = [UIColor clearColor];
        }
        
        _cellBackground.position = value;
        [self.backgroundView setNeedsDisplay];
    }
}

/* Forces the cellview to redraw */
-(void)redisplay {
    [_cellView setNeedsDisplay];
}

/* Called from the XTableViewController when editing is started */
-(void)beginEditing {
    if(_textField) {
        [_textField becomeFirstResponder];
    }
}

/* Called from the XTableViewController when editing is ended */
-(void)endEditing {
    if(_textField) {
        [_textField resignFirstResponder];
        _model.textFieldData = _textField.text;
    }
}

#pragma mark - Static Methods
/* Returns the height for this cell, based on the model, the table width, and a few other factors. */
+(CGFloat)cellHeight:(XTableViewCellModel*)model withTableWidth:(NSInteger)tableWidth withTableStyle:(UITableViewStyle)style {
    if(style == UITableViewStyleGrouped) {
        tableWidth -= 20;
    }
    
    if(model.accessory == UITableViewCellAccessoryDisclosureIndicator || model.accessory == UITableViewCellAccessoryCheckmark) {
        tableWidth -= 20;
    }
    
    if(model.accessory == UITableViewCellAccessoryDetailDisclosureButton) {
        tableWidth -= 33;
    }
    
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
            
        default:
            break;
    }
    
    return model.minimumHeight;
}

/* Returns the cell identifier for dequeueTableCellWithIdentifer function calls */
+(NSString*)cellIdentifier {
    return @"XTableViewCellIdentifier";
}

#pragma mark - Drawing
-(void)drawRect:(CGRect)rect {
    [self redisplay];
    [super drawRect:rect];
    if (_model == nil) {
        return;
    }
    
    //as much as I HATE switch statements.. Here we are.
    switch (_model.type) {
        case XCELL_EDITABLE_TEXT_WITH_TITLE:
        {
            NSInteger textWidth = self.frame.size.width - _model.padding.left - _model.padding.right;
            CGSize titleSize = [_model.title sizeWithFont:_model.titleFont
                              constrainedToSize:CGSizeMake(textWidth, 0)
                                  lineBreakMode:UILineBreakModeTailTruncation];
            
            if(_textField) {
                _textField.frame = CGRectMake(titleSize.width + _model.padding.left + 5, 
                                              _textField.frame.origin.y, 
                                              self.frame.size.width - _model.padding.left - _model.padding.right - titleSize.width - 5,
                                              _textField.frame.size.height);
            }
        }
            break;
            
        case XCELL_EDITABLE_TEXT:
            if(_textField) {
                _textField.frame = CGRectMake(_model.padding.left, 
                                              _textField.frame.origin.y, 
                                              self.frame.size.width - _model.padding.left - _model.padding.right,
                                              _textField.frame.size.height);
            }
            break;
            
        default:
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

/* Intial cell setup */
-(void)setupView {
    _textField = nil;
    
    CGRect viewFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    _cellView = [[XTableViewCellView alloc] initWithFrame:viewFrame];
    _cellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:_cellView];
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

