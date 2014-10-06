//
//  LocationsViewController.m
//  JSONHandler
//
//  Created by Phillipus on 28/10/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "LocationsViewController.h"
#import "LocationDetailViewController.h"
#import "Location.h"
#import "JSONLoader.h"
#import <CoreLocation/CoreLocation.h>//


@import CoreLocation;
@interface LocationsViewController () 

//Initital the latitude and longtitude
@property (strong, nonatomic) NSNumber *curLatitude;
@property (strong, nonatomic) NSNumber *curLongtitude;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;

@end

//// Location Manager Delegate Methods
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    NSLog(@"%@", [locations lastObject]);
//}

@implementation LocationsViewController			

- (void)viewDidLoad {
    [super viewDidLoad];

    //-------------------------------------------------------------
    if ([CLLocationManager locationServicesEnabled]) {
        self.manager = [[CLLocationManager alloc] init];
        self.geocoder = [[CLGeocoder alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = 0.5;
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            [self.manager requestWhenInUseAuthorization];
    
        [self.manager startUpdatingLocation];
    //-------------------------------------------------------------
    }
   
    // Create a new JSONLoader with a local file URL
    JSONLoader *jsonLoader = [[JSONLoader alloc] init];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"locations" withExtension:@"json"];

    // Load the data on a background queue...
    // As we are using a local file it's not really necessary, but if we were connecting to an online URL then we'd need it
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.locations = [jsonLoader locationsFromJSONFile:url];
        // Now that we have the data, reload the table data on the main UI thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
}



//CLLocationManagerDelegate Methods-------------------------------------------------------------


- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{ //If failed
    NSLog(@"Error: %@", error);
    NSLog(@"Oops! Failed to get location.");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"Location: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    //if (currentLocation != nil){
        //self.curLatitude = [NSNumber numberWithFloat:newLocation.coordinate.latitude];
        //self.curLongtitude = [NSNumber numberWithFloat:newLocation.coordinate.longitude];
        self.curLatitude = [NSNumber numberWithFloat:42.3314];
        self.curLongtitude = [NSNumber numberWithFloat:83.0458];
        NSLog(@"Latitude: %@",self.curLatitude);
        NSLog(@"Longtitude: %@",self.curLongtitude);
        
        
    //}
    
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0 ){
            self.placemark = [placemarks lastObject];
        }else{
            NSLog(@"%@",error.debugDescription);
        }
    }];
}
//-------------------------------------------------------------






// Just before showing the LocationDetailViewController, set the selected Location object
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationDetailViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    vc.location = [_locations objectAtIndex:indexPath.row];
}


#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    
    //Set filters to the list:

    Location *location = [_locations objectAtIndex:indexPath.row];
    

        cell.textLabel.text = location.name;
        cell.detailTextLabel.text = location.category;
    
        //Get the image for the cell
        //NSLog(@"%@",location.category);
        if ([cell.detailTextLabel.text rangeOfString:@"Automotive"].location != NSNotFound) {
            //NSLog(@"string does not contain bla");
            cell.imageView.image = [UIImage imageNamed:@"automotive.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Business"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"business.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Construction"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"construction.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Food"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"food.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Home"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"home.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Personal"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"personal.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Shopping"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"shopping.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Sports"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"sports.png"];
        }else if ([cell.detailTextLabel.text rangeOfString:@"Travel"].location != NSNotFound){
            cell.imageView.image = [UIImage imageNamed:@"travel.png"];
        }else {
        //NSLog(@"string contains bla!");
            cell.imageView.image = [UIImage imageNamed:@"location.png"];
        }


       

    
    return cell;


    
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_locations count];
}

@end
