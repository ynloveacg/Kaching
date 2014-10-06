//
//  LocationDetailViewController.m
//  JSONHandler
//
//  Created by Phillipus on 28/10/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "MapAnnotation.h"

@interface LocationDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteurlLabel;
@property (weak, nonatomic) IBOutlet UITextView *discountTextView;
//@property (weak, nonatomic) IBOutlet UISwitch *visitedSwitch;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSNumber *curLatitude;
@property (strong, nonatomic) NSNumber *curLongtitude;

@property (weak, nonatomic) IBOutlet UIImageView *webImage;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *addressImage;




@end

@implementation LocationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
    // We are delegate for map view
    self.mapView.delegate = self;
    
    // Set title - set the title of the navigation bar
    //self.title = self.location.name; //Make the page title the same one as the vendor name
    
    //set vendor name
    self.nameLabel.text = self.location.name;
    
    // set texts...
    self.categoryLabel.text = self.location.category;
    
    self.discountTextView.text = self.location.discount;
    // Bug in iOS 7 - setting UITextView selectable to NO in IB means we lose all font info, so we set selectable here
    self.discountTextView.selectable = NO;
    
    self.phoneImage.image = [UIImage imageNamed:@"phone.png"];
    self.phoneLabel.text = self.location.phone;
    
    self.webImage.image = [UIImage imageNamed:@"website.png"];
    self.websiteurlLabel.text = self.location.websiteurl;
    
    self.addressImage.image = [UIImage imageNamed:@"address.png"];
    
    //self.visitedSwitch.on = [self.location.visited boolValue];
    

    
    
    
    
    // Make a map annotation for a pin from the longitude/latitude points
    MapAnnotation *mapPoint = [[MapAnnotation alloc] init];
    mapPoint.coordinate = CLLocationCoordinate2DMake([self.location.latitude doubleValue], [self.location.longitude doubleValue]);
    mapPoint.title = self.location.name;
    
    // Add it to the map view
    [self.mapView addAnnotation:mapPoint];
    
    // Zoom to a region around the pin
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapPoint.coordinate, 500, 500);
    [self.mapView setRegion:region];
    self.mapView.showsUserLocation = YES;
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *view = nil;
    static NSString *reuseIdentifier = @"MapAnnotation";
    
    // Return a MKPinAnnotationView with a simple accessory button
    view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.canShowCallout = YES;
        view.animatesDrop = YES;
    }
    
    return view;
}



@end
