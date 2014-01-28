//
//  CircleView.m
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithOverlay:(id <MKOverlay>)overlay {
	NSAssert(0, @"-initWithSearchRadius: is the designated initializer");
	return nil;
}

- (id)initWithSearchRadius:(SearchRadius *)aSearchRadius;
{
	if ((self = [super initWithOverlay:aSearchRadius])) {
		[self.searchRadius addObserver:self forKeyPath:@"coordinate" options:0 context:nil];
		[self.searchRadius addObserver:self forKeyPath:@"radius" options:0 context:nil];
	}
    return self;
}

- (void)dealloc {
	[self.searchRadius removeObserver:self forKeyPath:@"coordinate"];
	[self.searchRadius removeObserver:self forKeyPath:@"radius"];
}

- (SearchRadius *)searchRadius {
    return (SearchRadius *)self.overlay;
}

- (void)createPath {
	CGMutablePathRef path = CGPathCreateMutable();
	CLLocationCoordinate2D center = self.searchRadius.coordinate;
	CGPoint centerPoint = [self pointForMapPoint:MKMapPointForCoordinate(center)];
	CGFloat radius = MKMapPointsPerMeterAtLatitude(center.latitude) * self.searchRadius.radius;
	CGPathAddArc(path, NULL, centerPoint.x, centerPoint.y, radius, 2.0f * M_PI, 0.0f, true);
    
	self.path = path;
	CGPathRelease(path);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
	[self invalidatePath];
}

@end
