//
//  TwitterXCellModel.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "TwitterXCellModel.h"

@interface TwitterXCellModel(Private)
-(NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
-(NSInteger)numDaysAgo:(NSDate*)date;
-(NSInteger)numHoursAgo:(NSDate*)date;
-(NSInteger)numMinutesAgo:(NSDate*)date;
@end

@implementation TwitterXCellModel
@synthesize posted, userPicture;

-(void)dealloc {
    [posted release];
    [userPicture release];
    [super dealloc];
}

+(id)modelWithType:(XTableViewCellStyle)type withTitle:(NSString*)title withContent:(NSString *)content 
          withDate:(NSDate*)posted withPicture:(UIImage*)userPicture {
    TwitterXCellModel *model = [[[TwitterXCellModel alloc] initWithType:type] autorelease];
    if(model) {
        model.title = title;
        model.content = content;
        model.posted = posted;
        model.userPicture = userPicture;
        
        model.padding = UIEdgeInsetsMake(5, 5, 5, 5);
        model.titleColor = [UIColor blackColor];
        model.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        
        model.contentColor = [UIColor blackColor];
        model.contentFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    }
    return model;
}

-(NSString*)dateAsString {
    NSInteger numDaysAgo = [self numDaysAgo:self.posted];
    NSInteger numHoursAgo = [self numHoursAgo:self.posted];
    NSInteger numMinutesAgo = [self numMinutesAgo:self.posted];
    
    NSString *dateString;
    
    if(numDaysAgo == 0) {
        if(numHoursAgo <= 0) {
            if(numMinutesAgo == 0) {
                dateString = @"Now";
            } else if(numMinutesAgo == 1) {
                dateString = @"1 min";
            } else {
                dateString = [NSString stringWithFormat:@"%i mins", numMinutesAgo];
            }
        } else {
            if(numHoursAgo == 1) {
                dateString = @"1 hour";
            } else {
                dateString = [NSString stringWithFormat:@"%i hours", numHoursAgo];
            }
        }
    } else if(numDaysAgo == 1) {
        dateString = @"1 day";
    } else if(numDaysAgo < 3) {
        dateString = [NSString stringWithFormat:@"%i days", numDaysAgo];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d"];
        dateString = [dateFormatter stringFromDate:self.posted];
        [dateFormatter release];
    }
    
    return dateString;
}

@end

@implementation TwitterXCellModel(Private)
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

-(NSInteger)numDaysAgo:(NSDate*)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    return [self daysBetweenDate:date andDate:today];
}

-(NSInteger)numHoursAgo:(NSDate*)date {    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time / 60 / 60;
}

-(NSInteger)numMinutesAgo:(NSDate*)date {
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time / 60;
}
@end