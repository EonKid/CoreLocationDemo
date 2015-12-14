//
//  ViewController.h
//  MyLocationDemo
//
//  Created by Aseem 1 on 14/12/15.
//  Copyright (c) 2015 codeBrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate >

@property (strong, nonatomic) IBOutlet UILabel *lblLat;

@property (strong, nonatomic) IBOutlet UILabel *lblLong;

@property (strong, nonatomic) IBOutlet UILabel *lblAddress;


- (IBAction)btnPressCurrentLocation:(id)sender;

@end

