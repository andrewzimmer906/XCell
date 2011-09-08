//
//  TwitterXCellModel.h
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTableViewCellModel.h"

@interface TwitterXCellModel : XTableViewCellModel {
    
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString *)content withDate:(NSDate*)posted withPicture:(UIImage*)userPicture;

@property(nonatomic, retain) NSDate *posted;
@property(nonatomic, retain) UIImage *userPicture;

-(NSString*)dateAsString;
@end
