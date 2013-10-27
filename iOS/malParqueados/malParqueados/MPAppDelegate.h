//
//  MPAppDelegate.h
//  malParqueados
//
//  Created by Oscar Robayo on 26/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MPAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) NSMutableDictionary* locationUser;
@property (strong, nonatomic) CLLocationManager * manager;

@end
