//
//  Airport.m
//  air.tickets
//
//  Created by macbookpro on 25.04.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airport.h"

@implementation Airport

-(instancetype)initWithDictionary:(NSDictionary *)dictinary
{
    self = [super init];
    if (self) {
        _timezone = [dictinary valueForKey:@"time_zone"];
        _translations = [dictinary valueForKey:@"name_translations"];
        _name = [dictinary valueForKey:@"name"];
        _countryCode = [dictinary valueForKey:@"country_code"];
        _cityCode = [dictinary valueForKey:@"city_code"];
        _code = [dictinary valueForKey:@"code"];
        _flightable = [dictinary valueForKey:@"flightable"];
        NSDictionary *coords = [dictinary valueForKey:@"coordinates"];
        if (coords && ![coords isEqual:[NSNull null]]) {
            NSNumber *lon = [coords valueForKey:@"lon"];
            NSNumber *lat = [coords valueForKey:@"lat"];
            if (![lon isEqual:[NSNull null]] && ![lat isEqual:[NSNull null]]) {
                _coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
        [self localizeName];
    }
    return self;
}

-(void)localizeName {
    if (!_translations) return;
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeId = [locale.localeIdentifier substringToIndex:2];
    if (localeId) {
        if ([_translations valueForKey:localeId]) {
            self.name = [_translations valueForKey:localeId];
        }
    }
}

@end
