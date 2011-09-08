///////////////////////////////////////////////////////////////////
//
//  TwitterXCellView.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import "TwitterXCellView.h"
#import "TwitterXCellModel.h"

@implementation TwitterXCellView
-(void)dealloc {
    [bgImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bgImage = [[UIImage imageNamed:@"twitterCellBG.png"] retain];
    }
    return self;
}


#pragma mark - Drawing
/* Performs all custom drawing needed to display the twitter-like cell. */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if( [_model isKindOfClass:[TwitterXCellModel class]] ) {
        TwitterXCellModel *model = (TwitterXCellModel*)_model;
        [bgImage drawInRect:rect];
        
        [model.userPicture drawInRect:CGRectMake(model.padding.left, model.padding.top, 50, 50)];
        
        NSInteger textWidth = self.frame.size.width - model.padding.left - model.padding.right - 60;
        
        CGSize titleSize = [model.title sizeWithFont:_model.titleFont
                             constrainedToSize:CGSizeMake(textWidth, 0)
                                 lineBreakMode:UILineBreakModeTailTruncation];
        
        CGSize contentSize = [model.content sizeWithFont:_model.contentFont
                                 constrainedToSize:CGSizeMake(textWidth, 9999)
                                     lineBreakMode:UILineBreakModeTailTruncation];
        
        NSInteger cellHeight = titleSize.height + 5 + contentSize.height + _model.padding.top + _model.padding.bottom;
        if(cellHeight < _model.minimumHeight) {
            cellHeight = _model.minimumHeight;
        }
        
        [model.titleColor set];
        [model.title drawInRect:CGRectMake(_model.padding.left + 60, _model.padding.top-2, titleSize.width, titleSize.height) 
                 withFont:_model.titleFont 
            lineBreakMode:UILineBreakModeTailTruncation 
                alignment:_model.titleAlignment];
        
        [model.contentColor set];
        [model.content drawInRect:CGRectMake(_model.padding.left + 60, _model.padding.top + titleSize.height, contentSize.width, contentSize.height) 
                   withFont:_model.contentFont
              lineBreakMode:UILineBreakModeTailTruncation 
                  alignment:_model.contentAlignment];
        
        UIColor *timeColor = [UIColor colorWithRed:183.0/256 green:183.0/256 blue:183.0/256 alpha:1];
        [timeColor set];
        [[model dateAsString] drawInRect:CGRectMake(model.padding.left + 60, model.padding.top-2, textWidth, 0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentRight];
        
    }
}


@end
