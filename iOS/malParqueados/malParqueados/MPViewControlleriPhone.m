//
//  MPViewControlleriPhone.m
//  malParqueados
//
//  Created by Oscar Robayo on 27/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import "MPViewControlleriPhone.h"
#import "MPTableViewCelliPhone.h"

@interface MPViewControlleriPhone ()

@end

@implementation MPViewControlleriPhone
{
    NSArray* _arrayCasos;
    NSString * _idUser;
}

- (NSArray *) arrayCasos
{
    return _arrayCasos;
}

- (NSString *) idUser
{
    return _idUser;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    
    self.comment.enabled = NO;
    //load initial view
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:4.598055599999999
                                                            longitude:-74.0758333
                                                                 zoom:16];
    self.outletMapG.camera=camera;
    
    // Background image
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoa.jpg"]];
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    
    [self loadWebServices];
    [super viewDidLoad];
	
}

-(void) loadWebServices {

    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://growlapps.w.pw/casos.php"]];
    NSError *error = nil;
    
    id casos = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &error];
    
    
    if (casos != nil && error == nil){
        //NSLog(@"Successfully deserialized...");
        if ([casos isKindOfClass:[NSDictionary class]]){
            NSDictionary *deserializedDictionary = (NSDictionary *)casos;
            NSLog(@"Dersialized JSON Dictionary = %@",deserializedDictionary);
            //prodDic = (NSDictionary *)jpruba;
        }
        else if ([casos isKindOfClass:[NSArray class]]){
            NSArray *deserializedArray = (NSArray *)casos;
            NSLog(@"Dersialized JSON Array = %@", deserializedArray);
            _arrayCasos = (NSArray *)casos;
            
        }
        else {
            // Some other object was returned. We don't know how to deal
            //with this situation as the deserializer only returns dictionaries or arrays
        }
    }
    else if (error != nil){
        NSLog(@"An error happened while deserializing the JSON data.");
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  [_arrayCasos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellID";
    
    MPTableViewCelliPhone *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //Configuración filtro SearchBar Controller
    
        NSDictionary *item = [_arrayCasos objectAtIndex:indexPath.row]; //here you get every user
        NSString *categoria=[item objectForKey:@"categoria"];
    

        cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        cell.placeCase.text = categoria;
        cell.imageCase.image = [UIImage imageNamed:@"news.png"];
           
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       // static NSString *CellIdentifier = @"cellID";
       // MPTableViewCelliPhone *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
        NSDictionary *item = [_arrayCasos objectAtIndex:indexPath.row]; //here you get every user
        NSString *categoria=[item objectForKey:@"categoria"];
        UIImage *foto=[item objectForKey:@"foto"];
        NSString *latitud=[item objectForKey:@"latitud"];
        NSString *longitud=[item objectForKey:@"longitud"];
        NSString *observacion=[item objectForKey:@"observacion"];
        NSString *perfil=[item objectForKey:@"perfil"];
        NSString *iduser=[item objectForKey:@"id"];
    
        _idUser=iduser;
        self.comment.enabled=YES;
    
        float latitudefloat  = [latitud floatValue];
        float longitudefloat = [longitud floatValue];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitudefloat
                                                                longitude:longitudefloat
                                                                     zoom:16];
        self.outletMapG.camera=camera;
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitudefloat, longitudefloat);
        
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.title = categoria;
        marker.snippet = perfil;
        //marker.icon = foto;
        marker.appearAnimation = YES;
        marker.map = self.outletMapG;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendReport:(id)sender {
    
    
        NSInteger count = [self.comment.text length];
    
    if (count <2) {
        UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"Atencion" 
                                                         message:@"Campo evaluacion no puede estar vacio"  
                                                        delegate:nil 
                                               cancelButtonTitle:@"Aceptar" 
                                               otherButtonTitles:nil];
        [alerta show];
        
            }else{
    
        NSString *idUser = _idUser;
        NSString *comment = self.comment.text;
        NSLog(@"id_user %@", idUser);
        NSLog(@"comment %@", comment);
                
                
        [self.comment resignFirstResponder];


    
    }
    
    
    NSString *urlString = @"http://growlapps.w.pw/update.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id_user\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_idUser dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comments\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.comment.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(returnString);
    NSLog(@"finish");
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
 
    [textField resignFirstResponder];
 
    return YES;
}

@end
