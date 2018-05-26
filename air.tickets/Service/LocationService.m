//
//  LocationService.m
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationService.h"
#import <UIKit/UIKit.h>

@interface LocationService () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@end

@implementation LocationService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"error" message:@"not_determine_current_city" preferredStyle: UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"close" style:(UIAlertActionStyleDefault) handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (!_currentLocation) {
        _currentLocation = [locations firstObject];
        [_locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceDidUpdateCurrentLocation object:_currentLocation];
    }
}

@end
