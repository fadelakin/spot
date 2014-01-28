//
//  CircleView.h
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SearchRadius.h"


@interface CircleView : MKOverlayPathView

- (id)initWithSearchRadius:(SearchRadius *)searchRadius;

@property (nonatomic, readonly, strong) SearchRadius *searchRadius;

@end
