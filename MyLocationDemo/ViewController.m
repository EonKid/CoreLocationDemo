//
//  ViewController.m
//  MyLocationDemo
//
//  Created by Aseem 1 on 14/12/15.
//  Copyright (c) 2015 codeBrew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager requestAlwaysAuthorization];
//     // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
//    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [locationManager requestWhenInUseAuthorization];
//    }
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressCurrentLocation:(id)sender {
    
    NSLog(@"Get location\n");
    locationManager = [[CLLocationManager alloc] init];
     geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate= self ;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];

    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{

    CLLocation *currentLocation = locations.lastObject;
    _lblLong.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    _lblLat.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    
     [locationManager stopUpdatingLocation];
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _lblAddress.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
   }

@end
