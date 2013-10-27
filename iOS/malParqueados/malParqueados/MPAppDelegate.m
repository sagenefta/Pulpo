//
//  MPAppDelegate.m
//  malParqueados
//
//  Created by Oscar Robayo on 26/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import "MPAppDelegate.h"

@implementation MPAppDelegate
{

    NSMutableDictionary* _locationUser;
    
}

- (NSMutableDictionary *)locationUser
{
    return _locationUser;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Implementación key GoogleMaps
    [GMSServices provideAPIKey:@"AIzaSyAPYs_Jbj1MNk6SlT8XB3UyVx8gXTaVPX4"];
    [self loadLocation]; //load current user location

    return YES;
}

-(void)loadLocation
{
    self.manager = [[CLLocationManager alloc]init];
    [self.manager startUpdatingLocation];
    
    NSMutableDictionary *userLocation = [[NSMutableDictionary alloc]init];
    NSNumber *latitude  = [NSNumber numberWithFloat:self.manager.location.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.manager.location.coordinate.longitude];
    
 
    
    [userLocation setValue:longitude forKey:@"Longitude"];
    [userLocation setValue:latitude  forKey:@"Latitude"];
    

    _locationUser = userLocation;
    
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
