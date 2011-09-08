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
-(NSString*)nameForSection:(NSInteger)section;
-(NSArray*)arrayForSection:(NSInteger)section;
-(void)destroyData;
-(void)keyboardWillShow:(NSNotification *)notification;
-(void)hideKeyboard;
-(void)didRotate:(NSNotification *)notification;
-(NSInteger)tagForIndexPath:(NSIndexPath*)path;
@end

@implementation XTableViewController
@synthesize delegate;
@synthesize sortSectionsAlphabetically = _sortSectionsAlphabetically;
@synthesize cellClass;

#pragma mark - Memory Management

#pragma mark - Initialization
-(id)initWithTableView:(UITableView*)tableView {
    self = [super init];
    if(self) {
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        _sortSectionsAlphabetically = NO;
        _curEditingModel = nil;
        cellClass = [XTableViewCell class];
        
        // Register notification when the keyboard will be shown (to get its size)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyboardWillShow:)
                                              name:UIKeyboardWillShowNotification
                                              object:nil];
        // Register notification when the device turns (to adjust the keyboard stuff.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(didRotate:)
                                              name:@"UIDeviceOrientationDidChangeNotification" object:nil];
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
    if(indexPath.section >= [[_data allKeys] count]) {
        [self logError:@"Section outside of bounds in modelForIndexPath:"];
    }
    NSArray *sectionArray = [self arrayForSection:indexPath.section];
    
    if(indexPath.row >= [sectionArray count]) {
        [self logError:@"Row outside of bounds in modelForIndexPath:"];
    }
    
    return [sectionArray objectAtIndex:indexPath.row];
}

-(NSIndexPath*)indexPathForModel:(XTableViewCellModel*)model {
    for(NSInteger i = 0; i < [[_data allKeys] count]; i++) {
        NSArray *sectionArray = [self arrayForSection:i];
        NSInteger row = [sectionArray indexOfObject:model];
        if(row > -1) {
            return [NSIndexPath indexPathForRow:row inSection:i];
        }
    }
    
    [self logError:@"Model not Found in indexPathForModel:"];
    return nil;
}

#pragma mark - Editing Methods
-(void)beginEditingWithModel:(XTableViewCellModel*)model {
    _curEditingModel = model;
}

-(void)endEditingWithModel:(XTableViewCellModel*)model {
    _curEditingModel = nil;
    [self hideKeyboard];
}

-(BOOL)beginEditingNextCell:(XTableViewCellModel*)model {
    NSIndexPath *path = [self indexPathForModel:model];
    
    for(NSInteger i = path.section; i < [[_data allKeys] count]; i++) {
        NSArray *sectionArray = [self arrayForSection:i];
        if(i == path.section) {
            for(NSInteger j = path.row; j < [sectionArray count]; j++) {
                XTableViewCellModel *curModel = (XTableViewCellModel*)[sectionArray objectAtIndex:j];
                if(curModel.tabEnabled && curModel != model) {
                    _curEditingModel = curModel;
                    XTableViewCell *oldCell = (XTableViewCell*)[_tableView viewWithTag:[self tagForIndexPath:path]];
                    [oldCell endEditing];
                    
                    XTableViewCell *newCell = (XTableViewCell*)[_tableView viewWithTag:[self tagForIndexPath:[NSIndexPath indexPathForRow:j inSection:i]]];
                    [newCell beginEditing];
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
                    return YES;
                }
            }
        } else {
            for(NSInteger j = path.row; j < [sectionArray count]; j++) {
                XTableViewCellModel *curModel = (XTableViewCellModel*)[sectionArray objectAtIndex:j];
                if(curModel.tabEnabled && curModel != model) {
                    _curEditingModel = curModel;
                    XTableViewCell *oldCell = (XTableViewCell*)[_tableView viewWithTag:[self tagForIndexPath:path]];
                    [oldCell endEditing];
                    
                    XTableViewCell *newCell = (XTableViewCell*)[_tableView viewWithTag:[self tagForIndexPath:[NSIndexPath indexPathForRow:j inSection:i]]];
                    [newCell beginEditing];
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
                    return YES;
                }
            }
        }
    }
    
    return NO;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(_data == nil) {
        [self logError:STANDARD_ERROR_MESSAGE];
        return nil;
    }
    
    NSString *title = [self nameForSection:section];
    if(![title isEqualToString:@""]) {
        return title;
    } else {
        return nil;
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTableViewCellModel *model = [self modelForIndexPath:indexPath];
    XTableViewCell *cell = (XTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[cellClass cellIdentifier]];
    if (cell == nil) {
        cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[cellClass cellIdentifier]] autorelease];
    }
    
    cell.model = model;
    cell.tag = [self tagForIndexPath:indexPath];
    return cell;
}

#pragma mark - TableView Delegate
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTableViewCellModel *model = [self modelForIndexPath:indexPath];
    return [cellClass cellHeight:model withTableWidth:tableView.frame.size.width withTableStyle:tableView.style];
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
    NSLog(@"Error in XTableViewController: %@", error);
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

/* Size the tableview accordingly */
-(void)keyboardWillShow:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    CGRect keyboardRect;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
    _previousKeyboardHeight = _keyboardHeight;
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        _keyboardHeight = keyboardRect.size.height;
    }
    else {
        _keyboardHeight = keyboardRect.size.width;
    }
    
    if(_curEditingModel != nil && !_keyboardIsShowing) {
        //calculate a new frame
        CGRect frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height - _keyboardHeight);
        
        [UIView animateWithDuration:.3
                         animations:^{ 
                             _tableView.frame = frame;
                         } 
                         completion:^(BOOL finished){
                         }];

        NSIndexPath *path = [self indexPathForModel:_curEditingModel];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        _keyboardIsShowing = YES;
    }
}

-(void)hideKeyboard {
    if(_keyboardIsShowing) {
        //calculate a new frame
        CGRect frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height + _keyboardHeight);
        
        [UIView animateWithDuration:.3
                         animations:^{ 
                             _tableView.frame = frame;
                         } 
                         completion:^(BOOL finished){
                         }];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
        _keyboardIsShowing = NO;
    }
}

-(void)didRotate:(NSNotification *)notification {	
    if(_keyboardIsShowing) {
        //calculate a new frame
        CGRect frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 
                                  _tableView.frame.size.height + (_previousKeyboardHeight - _keyboardHeight));
        
        [UIView animateWithDuration:.3
                         animations:^{ 
                             _tableView.frame = frame;
                         } 
                         completion:^(BOOL finished){
                         }];
        
        NSIndexPath *path = [self indexPathForModel:_curEditingModel];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

/* Create a tag based on the section and row of a cell */
-(NSInteger)tagForIndexPath:(NSIndexPath*)path {
    return path.section * 1000 + path.row + 1;
}

@end

