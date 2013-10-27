//
//  MPViewController.h
//  malParqueados
//
//  Created by Oscar Robayo on 26/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MPViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)SendPhoto:  (UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
