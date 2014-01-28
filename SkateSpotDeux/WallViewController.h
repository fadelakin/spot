//
//  WallViewController.h
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "Post.h"

@interface WallViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end

@protocol WallViewControllerHighlight <NSObject>

- (void)highlightCellForPost:(Post *)post;
- (void)unhighlightCellForPost:(Post *)post;

@end
