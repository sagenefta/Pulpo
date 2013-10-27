//
//  MPViewController.m
//  malParqueados
//
//  Created by Oscar Robayo on 26/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import "MPViewController.h"
#import "MPAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MPViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation MPViewController

{
    NSArray* _categoryName;
    NSString* _perfilUser;
}

- (NSArray *) categoryName
{
    return _categoryName;
}

- (NSString *) perfilUser
{
    return _perfilUser;
}
- (void)viewDidLoad
{
    
    
    _categoryName = @[@"Loco Desquiciado", @"Mandril",
                      @"Atravezado", @"Despistado"];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    // Background image
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoa.jpg"]];
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    
    
    // Header logo
    UIImageView* header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logofinal.png"]];
    header.center = CGPointMake(650, 115);
    [self.view addSubview:header];
    

   //[self.picker setBackgroundColor:[UIColor grayColor]];
    _perfilUser =@"Loco Desquiciado";
    
    
    
    
    
    [super viewDidLoad];
	
}

- (NSMutableDictionary *)locationUser {
    
    MPAppDelegate* appDelegate = (MPAppDelegate*)
    [[UIApplication sharedApplication] delegate];
    return appDelegate.locationUser;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)SendPhoto:(UIButton *)sender {

   [self.activity startAnimating];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.2);
    
    if (imageData != nil)
    {
        NSString *id_user = [NSString stringWithFormat:@"US001"];
        NSString *category  = _perfilUser;
        NSString *latitudeNumber =  [[self locationUser] valueForKey:@"Latitude"];
        NSString *longitudeNumber = [[self locationUser] valueForKey:@"Longitude"];
        NSString *latitudeString = [NSString stringWithFormat:@"%@", latitudeNumber];
        NSString *longitudeString = [NSString stringWithFormat:@"%@", longitudeNumber];
        
        NSLog(@"id_user %@", id_user);
        NSLog(@"category %@", category);
        NSLog(@"latitude %@", latitudeString);
        NSLog(@"longitude %@", longitudeString);
        
        NSString *urlString = @"http://growlapps.w.pw/recibe.php";
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id_user\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[id_user dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"category\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[category dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[latitudeString dataUsingEncoding:NSUTF8StringEncoding]];

        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[longitudeString dataUsingEncoding:NSUTF8StringEncoding]];


        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        // now lets make the connection to the web
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(returnString);
        NSLog(@"finish");
        

        UIImageView* header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Atras.jpg"]];
        self.imageView.image =  header.image;
        [self.activity stopAnimating];
      

        
  
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _categoryName.count;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{

    NSLog(@"result %@", _categoryName[row]);
    _perfilUser =_categoryName[row];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-light" size:25];
    
    
    if ([_categoryName [row] isEqualToString:@"Loco Desquiciado"]) {
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@" %@", _categoryName[row]];
    }else if ([_categoryName [row] isEqualToString:@"Mandril"]){
        label.backgroundColor = [UIColor orangeColor];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@" %@", _categoryName[row]];
    }else if ([_categoryName [row] isEqualToString:@"Atravezado"]){
        label.backgroundColor = [UIColor blueColor];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@" %@", _categoryName[row]];
    }else if ([_categoryName [row] isEqualToString:@"Despistado"]){
        label.backgroundColor = [UIColor greenColor];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@" %@", _categoryName[row]];
    }
    return label;
}


@end
