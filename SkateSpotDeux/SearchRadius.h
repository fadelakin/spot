//
//  SearchRadius.h
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//


#import <MapKit/MapKit.h>

@interface SearchRadius : NSObject <MKOverlay>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) CLLocationDistance radius;
@property (nonatomic, assign) MKMapRect boundingMapRect;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate radius:(CLLocationDistance)radius;

@end
