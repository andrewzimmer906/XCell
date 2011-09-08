//
//  TwitterViewController.m
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import "TwitterViewController.h"
#import "TwitterXCellModel.h"
#import "TwitterXCell.h"
#import "XTableViewController.h"

@interface TwitterViewController(Private)
-(NSArray*)tableData;
@end

@implementation TwitterViewController
@synthesize tableView;

#pragma mark - Memory Management
-(void)dealloc {
    [tableView release];
    [_tableController release];
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Overriden Custom Cells";
    _tableController = [[XTableViewController alloc] initWithTableView:tableView];
    _tableController.delegate = self;
    _tableController.cellClass = [TwitterXCell class];
    [_tableController setDataWithArray:[self tableData]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end

@implementation TwitterViewController(Private)

-(NSArray*)tableData {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:100];
    for(int i = 0; i < 25; i++) {
        XTableViewCellModel *cell1 = [TwitterXCellModel modelWithType:XCELL_OVERRIDE_TWITTER withTitle:@"andrewzimmer906" withContent:@"Our custom cell is going to look like twitter. Seems like a decent benchmark." withDate:[NSDate date] withPicture:[UIImage imageNamed:@"Andrew_Zimmer.png"]];
        
        XTableViewCellModel *cell2 = [TwitterXCellModel modelWithType:XCELL_OVERRIDE_TWITTER withTitle:@"fake_twitter_handle" withContent:@"And what is going to be really interesting is to check out our performance." withDate:[NSDate dateWithTimeIntervalSinceNow:(-60*5)] withPicture:[UIImage imageNamed:@"jess-in-a-box.png"]];
        
        XTableViewCellModel *cell3 = [TwitterXCellModel modelWithType:XCELL_OVERRIDE_TWITTER withTitle:@"andrewzimmer906" withContent:@"Indeed @fake_twitter_handle. Let's populate this screen with 100 cells and see how well things scroll." withDate:[NSDate dateWithTimeIntervalSinceNow:(-60*60)] withPicture:[UIImage imageNamed:@"Andrew_Zimmer.png"]];
        
        XTableViewCellModel *cell4 = [TwitterXCellModel modelWithType:XCELL_OVERRIDE_TWITTER withTitle:@"fake_twitter_handle" withContent:@"Since we are drawing everything into one view as opposed to adding multiple subviews, this baby should run fast!" withDate:[NSDate dateWithTimeIntervalSinceNow:(-60*60*25)] withPicture:[UIImage imageNamed:@"jess-in-a-box.png"]];
        
        XTableViewCellModel *cell5 = [TwitterXCellModel modelWithType:XCELL_OVERRIDE_TWITTER withTitle:@"fake_twitter_handle" withContent:@"Also, you do realize that this conversation makes no chronological sense, right?" withDate:[NSDate dateWithTimeIntervalSinceNow:(-60*60*48)] withPicture:[UIImage imageNamed:@"jess-in-a-box.png"]];
        
        [tempArray addObject:cell1];
        [tempArray addObject:cell2];
        [tempArray addObject:cell3];
        [tempArray addObject:cell4];
        [tempArray addObject:cell5];
    }
    
    NSArray *returnArray = [NSArray arrayWithArray:tempArray];
    [tempArray release];
    
    return returnArray;
}

@end