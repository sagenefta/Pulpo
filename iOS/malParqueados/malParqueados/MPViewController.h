//
//  MPViewController.h
//  malParqueados
//
//  Created by Oscar Robayo on 26/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewSend;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)SendPhoto:  (UIButton *)sender;

@end
