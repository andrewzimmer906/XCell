//
//  TwitterXCell.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "TwitterXCell.h"
#import "TwitterXCellView.h"
#import "TwitterXCellModel.h"

@interface TwitterXCell(Private)
@end

@implementation TwitterXCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _textField = nil;
        
        if(_cellView) {
            [_cellView removeFromSuperview];
            [_cellView release];
        }
        CGRect viewFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        _cellView = [[TwitterXCellView alloc] initWithFrame:viewFrame];
        _cellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_cellView];
        
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

+(CGFloat)cellHeight:(XTableViewCellModel *)model withTableWidth:(NSInteger)tableWidth withTableStyle:(UITableViewStyle)style {
    if( [model isKindOfClass:[TwitterXCellModel class]] ) {
        TwitterXCellModel *curModel = (TwitterXCellModel*)model;
        
        NSInteger textWidth = tableWidth - model.padding.left - model.padding.right - 60;        
        CGSize titleSize = [curModel.title sizeWithFont:curModel.titleFont
                                   constrainedToSize:CGSizeMake(textWidth, 0)
                                   lineBreakMode:UILineBreakModeTailTruncation];
        
        CGSize contentSize = [curModel.content sizeWithFont:curModel.contentFont
                                    constrainedToSize:CGSizeMake(textWidth, 9999)
                                    lineBreakMode:UILineBreakModeTailTruncation];
        
        NSInteger cellHeight = titleSize.height + 5 + contentSize.height + curModel.padding.top + curModel.padding.bottom;
        if(cellHeight < curModel.minimumHeight) {
            cellHeight = curModel.minimumHeight;
        }
        
        return cellHeight;
    } else {
        return [super cellHeight:model withTableWidth:tableWidth withTableStyle:style];
    }
}

@end
