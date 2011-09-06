//
//  XTableViewControllerDelegate.h
//  XCell
//
//  Created by Andrew Zimmer on 9/5/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XTableViewControllerDelegate <NSObject>
@optional
-(void)cellClicked:(NSIndexPath*)path;
@end
