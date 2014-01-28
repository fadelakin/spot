//
//  WelcomeViewController.m
//  SkateSpotDeux
//
//  Created by Fisher on 1/19/14.
//  Copyright (c) 2014 Fisher Adelakin. All rights reserved.
//

#import "WelcomeViewController.h"

#import "WallViewController.h"
#import "LoginViewController.h"
#import "NewUserViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Transition methods

- (IBAction)loginButtonSelected:(id)sender {
	//LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [sb instantiateViewControllerWithIdentifier:@"login"];
	[self.navigationController presentViewController:loginViewController animated:YES completion:^{}];
}

- (IBAction)createButtonSelected:(id)sender {
	// WelcomeViewController *newUserViewController = [[WelcomeViewController alloc] initWithNibName:nil bundle:nil]
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *newUserViewController = [sb instantiateViewControllerWithIdentifier:@"new"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newUserViewController];
	[self.navigationController presentViewController:navigationController animated:YES completion:^{}];
    //[self.navigationController presentViewController:newUserViewController animated:YES completion:^{}];
}

- (IBAction)gotoParse:(id)sender {
	UIApplication *ourApplication = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://www.parse.com/"];
    [ourApplication openURL:url];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
