//
//  XTableViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//

#import "XTableViewController.h"
#import "XTableViewCell.h"
#import "XTableViewCellModel.h"

#define STANDARD_ERROR_MESSAGE @"Data is nil. Initialize your XTableViewController with \"-(void)setDataWithDictionary:(NSDictionary*)data\" or \"-(void)setDataWithArray:(NSDictionary*)array\""

@interface XTableViewController(Private)
-(void)logError:(NSString*)error;
-(NSArray*)arrayForSection:(NSInteger)section;
-(void)destroyData;
@end

@implementation XTableViewController
@synthesize delegate;
@synthesize sortSectionsAlphabetically = _sortSectionsAlphabetically;

#pragma mark - Memory Management

#pragma mark - Initialization
-(id)initWithTableView:(UITableView*)tableView {
    self = [super init];
    if(self) {
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        _sortSectionsAlphabetically = NO;
    }
    return self;
}

#pragma mark - Data Setting Methods
-(void)setDataWithDictionary:(NSDictionary*)data {
    [self destroyData];
    
    /* Make a deep copy of the data */
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithCapacity:[data count]];
    for(NSString *key in [data allKeys]) {
        NSArray *tempArray = [data objectForKey:key];
        NSArray *newArray = [[NSArray alloc] initWithArray:tempArray];
        [tempDictionary setObject:newArray forKey:key];
    }
    
    _data = [[NSDictionary alloc] initWithDictionary:tempDictionary];
    [tempDictionary release];
}

-(void)setDataWithArray:(NSArray*)array {
    [self destroyData];
    
    NSArray *newArray = [[NSArray alloc] initWithArray:array];    
    _data = [[NSDictionary alloc] initWithObjectsAndKeys:newArray, @"", nil];
}

#pragma mark - Data Retrieval Methods
-(XTableViewCellModel*)modelForIndexPath:(NSIndexPath*)indexPath {
    NSArray *sectionArray = [self arrayForSection:indexPath.section];
    return [sectionArray objectAtIndex:indexPath.row];
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_data == nil) {
        [self logError:STANDARD_ERROR_MESSAGE];
        return 0;
    }
    
    return [[_data allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_data == nil) {
        [self logError:STANDARD_ERROR_MESSAGE];
        return 0;
    }
    
    NSArray *sectionArray = [self arrayForSection:section];
    return [sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTableViewCellModel *model = [self modelForIndexPath:indexPath];
    XTableViewCell *cell = (XTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[XTableViewCell cellIdentifier]];
    if (cell == nil) {
        cell = [[[XTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XTableViewCell cellIdentifier]] autorelease];
    }
    
    cell.model = model;
    return cell;
}

#pragma mark - TableView Delegate
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTableViewCellModel *model = [self modelForIndexPath:indexPath];
    return [XTableViewCell cellHeight:model withTableWidth:tableView.frame.size.width];
}

/* Throw any clicks up to the delegate (most likely the view controller) */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([delegate respondsToSelector:@selector(cellClicked:)]) {
        [delegate cellClicked:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

#pragma mark - Private -
@implementation XTableViewController(Private)
/*
   Logs an error to the console
*/
-(void)logError:(NSString*)error {
    NSLog(@"XTableViewConroller: %@", error);
}

/*
 Gets the array for the section
 */
-(NSString*)nameForSection:(NSInteger)section {
    if(_data == nil) {
        [self logError:@"_data is nil in private method nameForSection:"];
        return nil;
    }
    
    if(_sortSectionsAlphabetically) {
        NSArray *sorted = [[_data allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return [sorted objectAtIndex:section];
    } else {
        return [[_data allKeys] objectAtIndex:section];
    }
}

/*
   Gets the array for the section
*/
-(NSArray*)arrayForSection:(NSInteger)section {
    if(_data == nil) {
        [self logError:@"_data is nil in private method getSectionArray:"];
        return nil;
    }
    
    return [_data objectForKey:[self nameForSection:section]];
}

/* Releases Data Completly */
-(void)destroyData {
    if(_data != nil) {
        for(NSArray* array in [_data allValues]) {
            [array release];
        }
        [_data release];
        _data = nil;
    }
}

@end

