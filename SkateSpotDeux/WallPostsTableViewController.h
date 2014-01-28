//
//  WallPostsTableViewController.h
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "WallViewController.h"

@interface WallPostsTableViewController : PFQueryTableViewController <WallViewControllerHighlight>

- (void)highlightCellForPost:(Post *)post;
- (void)unhighlightCellForPost:(Post *)post;

@end
