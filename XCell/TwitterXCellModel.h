///////////////////////////////////////////////////////////////////
//
//  TwitterXCellModel.h
//  XCell
//
//  Override of the standard XTableViewCellModel to create a 
//  twitter-like cell.
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
///////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "XTableViewCellModel.h"

@interface TwitterXCellModel : XTableViewCellModel {
    
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString *)content withDate:(NSDate*)posted withPicture:(UIImage*)userPicture;

@property(nonatomic, retain) NSDate *posted;
@property(nonatomic, retain) UIImage *userPicture;

-(NSString*)dateAsString; //gets a twitter style string from the posted variable.
@end
