//
//  MPViewControlleriPhone.h
//  malParqueados
//
//  Created by Oscar Robayo on 27/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface MPViewControlleriPhone : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *outletMapG;
- (IBAction)sendReport:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *comment;

@end
