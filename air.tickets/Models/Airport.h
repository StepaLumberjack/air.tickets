//
//  Airport.h
//  air.tickets
//
//  Created by macbookpro on 25.04.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface Airport: NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, getter=isFlightable) BOOL flightable;
@property (nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithDictionary:(NSDictionary *)dictinary;

@end
