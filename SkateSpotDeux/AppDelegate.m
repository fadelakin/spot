//
//  AppDelegate.m
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

static NSString * const defaultsFilterDistanceKey = @"filterDistance";
static NSString * const defaultsLocationKey = @"currentLocation";

#import "AppDelegate.h"

#import <Parse/Parse.h>

#import "WelcomeViewController.h"
#import "WallViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize filterDistance;
@synthesize currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    // Parse initialization
	[Parse setApplicationId:@"insert application id here" clientKey:@"insert client key here"];
    
    // Grab values from NSUserDefaults:
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	// Set the global tint on the navigation bar
	[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:200.0f/255.0f green:83.0f/255.0f blue:70.0f/255.0f alpha:1.0f]];
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
	
	if ([userDefaults doubleForKey:defaultsFilterDistanceKey]) {
        // use the ivar instead of self.accuracy to avoid an unnecessary write to NAND on launch.
        // filterDistance = [userDefaults doubleForKey:defaultsFilterDistanceKey];
        filterDistance = [userDefaults doubleForKey:defaultsLocationKey];
    } else {
        // if we have no accuracy in defaults, set it to 1000 feet.
        self.filterDistance = 1000 * kPAWFeetToMeters;
    }
    
	UINavigationController *navController = nil;
    
	if ([PFUser currentUser]) {
		// Skip straight to the main view.
		// WallViewController *wallViewController = [[WallViewController alloc] initWithNibName:nil bundle:nil];
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *wallViewController = [sb instantiateViewControllerWithIdentifier:@"wall"];
        // [(UINavigationController *)self.viewController pushViewController:wallViewController animated:NO];
		navController = [[UINavigationController alloc] initWithRootViewController:wallViewController];
		navController.navigationBarHidden = NO;
		self.viewController = navController;
		self.window.rootViewController = self.viewController;
	} else {
		// Go to the welcome screen and have them log in or create an account.
		[self presentWelcomeViewController];
	}
	
	[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setFilterDistance:(CLLocationAccuracy)aFilterDistance {
	filterDistance = aFilterDistance;
    
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setDouble:filterDistance forKey:defaultsFilterDistanceKey];
	[userDefaults synchronize];
    
	// Notify the app of the filterDistance change:
	 NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:filterDistance] forKey:kPAWFilterDistanceKey];
	dispatch_async(dispatch_get_main_queue(), ^{
		[[NSNotificationCenter defaultCenter] postNotificationName:kPAWFilterDistanceChangeNotification object:NO userInfo:userInfo];
	});
}

- (void)setCurrentLocation:(CLLocation *)aCurrentLocation {
	// currentLocation = aCurrentLocation;
    
    if(currentLocation) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:currentLocation forKey:kPAWLocationKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kPAWLocationChangeNotification object:nil userInfo:userInfo];
        });
    }
    
	// Notify the app of the location change:
    // NSDictionary *userInfo = [NSDictionary dictionaryWithObject:currentLocation forKey:kPAWLocationKey];
}

- (void)presentWelcomeViewController {
	// Go to the welcome screen and have them log in or create an account.
	// WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"PAWWelcomeViewController" bundle:nil];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *welcomeViewController = [sb instantiateViewControllerWithIdentifier:@"welcome"];
	welcomeViewController.title = @"Check out skate spots in your town";
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
	navController.navigationBarHidden = YES;
    
	self.viewController = navController;
	self.window.rootViewController = self.viewController;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
